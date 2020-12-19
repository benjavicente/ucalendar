# frozen_string_literal: true

require_relative '../lib/expandable_event'

# Horario
class Schedule < ApplicationRecord
  has_many :schedule_events, dependent: :destroy
  belongs_to :course

  def to_icalendar_events
    map_events_to_expandable_events
    expand_events_horizontaly
    expand_events_verticaly
    create_icalendar_events
  end

  def to_google_calendar_events; end

  private

  MODULE_LENGH = Rational(1, 18) # Time delta
  ICALENDAR_DAYS = { 0 => 'MO', 1 => 'TU', 2 => 'WE', 3 => 'TH', 4 => 'FR', 5 => 'SA', 6 => 'SU' }.freeze
  MODULES_TIME = {
    0 => { hour: 8, min: 30 },
    1 => { hour: 10, min: 0 },
    2 => { hour: 11, min: 30 },
    3 => { hour: 14, min: 0 },
    4 => { hour: 15, min: 30 },
    5 => { hour: 17, min: 0 },
    6 => { hour: 18, min: 30 },
    7 => { hour: 20, min: 0 }
  }.freeze

  def map_events_to_expandable_events
    @expandable_events = schedule_events.map do |e|
      ExpandableEvent.new(e.day, e.module, e.category, e.classroom)
    end
  end

  def expand_events_horizontaly
    ScheduleEvent::DAYS.each do |day|
      @last_event = nil
      ScheduleEvent::MODULES.each do |mod|
        try_to_expand_event day, mod
      end
    end
  end

  def expand_events_verticaly
    ScheduleEvent::MODULES.each do |mod|
      @last_event = nil
      ScheduleEvent::DAYS.each do |day|
        try_to_expand_event day, mod
      end
    end
  end

  def try_to_expand_event(day, mod)
    @expandable_events.each do |event|
      next unless event.in?(day, mod)

      if @last_event.nil?
        @last_event = event
      elsif @last_event.category == event.category && @last_event.classroom == event.classroom
        @last_event << event
        @expandable_events.delete event
      end
    end
  end

  def create_icalendar_events
    # %Y%m%dT%H%M
    @expandable_events.map do |event|
      # Info
      until_date = course.term.last_day
      days = event.days.map { |e| ICALENDAR_DAYS[e] }.join(',')
      event_start = course.term.first_day.to_datetime.change(MODULES_TIME[event.modules.min])
      event_end = course.term.first_day.to_datetime.change(MODULES_TIME[event.modules.max])
      # Calendar
      icalendar_event = Icalendar::Event.new
      icalendar_event.summary = "#{course} - #{event.category}"
      icalendar_event.description = "#{course.subject.name}\nprofes:"
      icalendar_event.dtstart = event_start
      icalendar_event.dtend = event_end + MODULE_LENGH
      exdates = Holiday.all.filter_map do |holiday|
        holiday.change(year: course.term.first_day.year) if holiday.every_yeat
        course.term.first_day < holiday.day && holiday.day < course.term.last_day ? holiday.day : nil
      end
      icalendar_event.exdate = exdates
      icalendar_event.rrule = "FREQ=WEEKLY;INTERVAL=1;BYDAY=#{days};UNTIL=#{until_date.strftime('%Y%m%d')}Z"
      icalendar_event
    end
  end
end
