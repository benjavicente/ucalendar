# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :courses, dependent: :destroy

  def display_name
    code
  end
end
