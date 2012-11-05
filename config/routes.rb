require 'sidekiq/web'

WalterBishop::Application.routes.draw do
  resources :episodes, :only => :index
  mount Sidekiq::Web => '/sidekiq'
  root :to => redirect('/episodes')
end
