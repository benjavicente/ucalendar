# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :courses

  def display_name
    code
  end
end
