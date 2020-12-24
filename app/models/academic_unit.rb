# frozen_string_literal: true

class AcademicUnit < ApplicationRecord
  has_many :courses, dependent: :destroy
end
