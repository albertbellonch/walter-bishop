require 'sidekiq/web'
require 'sidetiq/web'

Rails.application.routes.draw do
  namespace :api do
    resources :episodes, only: :index
    resources :shows, only: :index
  end

  mount Sidekiq::Web => '/admin/sidekiq'
end
