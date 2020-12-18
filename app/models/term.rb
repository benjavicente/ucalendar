# frozen_string_literal: true

# Periodo de clases
class Term < ApplicationRecord
  enum period: %i[tav 1 2]

  has_many :courses, dependent: :destroy

  def to_s
    display_name
  end

  def display_name
    "#{year}-#{period}"
  end
end
