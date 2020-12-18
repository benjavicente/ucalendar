# frozen_string_literal: true

ActiveAdmin.register Term do
  permit_params :year, :period, :first_day, :last_day
end
