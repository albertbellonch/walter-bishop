Rails.application.routes.draw do
  namespace :api do
    resources :episodes, only: :index
    resources :shows, only: :index
  end
end
