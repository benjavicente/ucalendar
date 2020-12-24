# frozen_string_literal: true

# Periodo de clases
class Term < ApplicationRecord
  enum period: %i[1 2 tav]
  default_scope { order(year: :desc, period: :asc) }

  has_many :courses, dependent: :destroy

  def to_s
    display_name
  end

  def display_name
    "#{year}-#{period}"
  end

  def period_int
    period == 'tav' ? 3 : period
  end
end
