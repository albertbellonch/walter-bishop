source 'https://rubygems.org'

# Rails
gem 'rails', '4.2.4'
gem 'rails-api'

# API
gem 'active_model_serializers', '~> 0.10.0.rc2'
gem 'responders'

# Storage
gem 'mysql2', '~> 0.3.18'

# Background
gem 'sidekiq'
gem 'sidetiq'
gem 'sinatra', require: nil

# Tools
gem 'icalendar'
gem 'baudelaire'

# Error tracking
gem 'rollbar'

# Groups
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
