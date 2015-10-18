Rails.application.routes.draw do
  resources :episodes, only: :index
end
