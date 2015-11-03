source 'https://rubygems.org'

# Rails
gem 'rails', '4.2.4'
gem 'rails-api'

# API
gem 'active_model_serializers', '~> 0.10.0.rc2'
gem 'responders'

# Models
gem 'baudelaire'

# Storage
gem 'mysql2', '~> 0.3.18'

# Background
gem 'sidekiq', '3.3.4'
gem 'sidetiq'
gem 'sinatra', require: nil
gem 'rack-protection' # used in config.ru for protection

# APIs
gem 'icalendar'

# Assets
gem 'quiet_assets'

# Groups
group :production, :staging do
  gem 'unicorn'
  gem 'rollbar'
end

group :development do
  # Deployment
  gem 'capistrano'
  gem 'capistrano-rails', '1.1.3'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  gem 'capistrano3-unicorn'
  gem 'slackistrano', require: false

  # Tools
  gem 'spring'
  gem 'thin'
end

group :test do
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
end
