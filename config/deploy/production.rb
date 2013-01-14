set :branch, "master"
set :rails_env, "production"
set :deploy_to, "/var/www/rails/home.bellonch.com"

server "home.bellonch.com", :app, :worker, :web, :db, :primary => true
