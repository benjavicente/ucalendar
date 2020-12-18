# frozen_string_literal: true

require 'set'

# Evento que puede expanderse (recurrente en la semana)
class ExpandableEvent
  attr_reader :days, :modules, :category, :classroom

  def initialize(day, mod, category, classroom)
    @days = SortedSet[day]
    @modules = SortedSet[mod]
    @category = category
    @classroom = classroom
  end

  def in?(day, mod)
    @days.include?(day) && @modules.include?(mod)
  end

  def <<(other)
    if @days == other.days
      @modules |= other.modules
    elsif @modules == other.modules
      @days |= other.days
    end
  end
end
