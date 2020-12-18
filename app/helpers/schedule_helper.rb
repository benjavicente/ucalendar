# frozen_string_literal: true

require_relative '../lib/buscacursos_scraper'

module ScheduleHelper
  def buscacursos_url(courses, term)
    BuscacursosScraper.instance.get_schedule_url(courses.map(&:to_s), term.period, term.year)
  end
end
