# frozen_string_literal: true

class ScheduleEvent < ApplicationRecord
  enum category: %i[class assis lab workshop field practice tesis other]
  belongs_to :schedule
end
