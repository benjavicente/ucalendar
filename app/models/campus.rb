# frozen_string_literal: true

class Campus < ApplicationRecord
  has_many :courses, dependent: :destroy
end
