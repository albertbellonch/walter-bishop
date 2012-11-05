WalterBishop::Application.routes.draw do
  resources :episodes, :only => :index
  root :to => redirect('/episodes')
end
