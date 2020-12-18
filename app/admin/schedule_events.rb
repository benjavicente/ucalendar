# frozen_string_literal: true

ActiveAdmin.register ScheduleEvent do
  permit_params :schedule_id, :type, :classroom, :day, :module
end
