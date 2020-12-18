# frozen_string_literal: true

ActiveAdmin.register Holiday do
  permit_params :day, :name, :every_yeat
end
