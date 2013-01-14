source 'https://rubygems.org'

# Rails
gem 'rails', '3.2.11'

# DB
gem 'mysql2'

# Frontend
gem 'jquery-rails'
gem 'slim-rails'
gem 'compass-rails'
gem 'compass_twitter_bootstrap'

# Scheduling
gem 'sidekiq'
gem 'sinatra', :require => nil
gem 'whenever'

# Utils
gem 'quiet_assets'
gem 'nokogiri'

# APIs and external services
gem 'icalendar'

# Deployment
gem 'capistrano'
gem 'capistrano-ext'
gem 'capistrano_colors', :require => false
gem 'rvm-capistrano'

## Groups

# Assets
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# Development do
group :development do
  gem 'thin'
end

# Test
group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'fuubar'
end
