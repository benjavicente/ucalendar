# frozen_string_literal: true

class ScheduleEvent < ApplicationRecord
  enum category: %i[class assis lab workshop field practice tesis other]
  belongs_to :schedule

  DAYS = (0..5).to_a.freeze
  MODULES = (0..7).to_a.freeze
end
