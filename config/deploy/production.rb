set :branch, "master"
set :rails_env, "production"
set :deploy_to, "/var/www/rails/pi.bellonch.com"

server "home.bellonch.com", roles: %i{ app db worker }, primary: true
