# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'schedule#show_short'
  get 't/s', to: 'schedule#show_short', as: 'schedule_short'
  get 'term/:year/:period/schedule', to: 'schedule#show', as: 'schedule'
end
