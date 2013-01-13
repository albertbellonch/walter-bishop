load 'deploy'
load 'config/deploy'
load 'deploy/assets'

Dir['config/deploy/recipes/*.rb'].each { |plugin| load(plugin) }

require 'capistrano/ext/multistage'
require "rvm/capistrano"
require 'capistrano_colors'
require 'bundler/capistrano'
require 'sidekiq/capistrano'
