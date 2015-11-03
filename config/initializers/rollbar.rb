require 'rollbar/rails'

Rollbar.configure do |config|
  config.access_token = Rails.application.secrets.rollbar_server_token
  config.enabled = Rails.env.production?
end
