# frozen_string_literal: true

ActiveAdmin.register Subject do
  menu priority: 2
  permit_params :code, :name, :credits, :fr_area, :category
end
