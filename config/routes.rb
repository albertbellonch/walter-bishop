require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    resources :episodes, only: :index
    resources :shows, only: :index
  end

  namespace :admin do
    mount Sidekiq::Web => '/sidekiq'
  end
end
