Rails.application.routes.draw do
  resources :episodes, only: :index
  resources :shows, only: :index
end
