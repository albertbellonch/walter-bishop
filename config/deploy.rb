# Require sidekiq, unicorn and rollbar recipes
require 'capistrano/sidekiq'
require 'capistrano3/unicorn'
require 'rollbar/capistrano3'

# Application
set :application, "walter-bishop"

# Repo & connection
set :scm, :git
set :repo_url, "git@github.com:albertbellonch/walter-bishop-api.git"
set :user, 'deployer'
set :port, 8622
set :ssh_options, { user: fetch(:user), port: fetch(:port), forward_agent: true }

# RVM
set :rvm_ruby_version, File.open('.ruby-version', 'r').read.chomp("\n")
set :rvm_type, :system

# Misc
set :log_level, :info
set :linked_files, %w{ database secrets }.map { |name| "config/#{name}.yml" }
set :linked_dirs, ['log', 'tmp/cache']
set :keep_releases, 5
set :format, :pretty
set :pty, false

# Unicorn
set :unicorn_pid, -> { "#{deploy_to}/shared/pids/unicorn.pid" }
set :unicorn_roles, :app
set :unicorn_rack_env, :deployment
set :unicorn_config_path, -> { "#{deploy_to}/current/config/unicorn/#{fetch(:rails_env)}.rb" }

# Sidekiq & roles
set :sidekiq_pid, -> { File.join(shared_path, 'pids', 'sidekiq.pid') }
set :sidekiq_role, :worker
set :assets_roles, [:web, :app, :worker]
set :bundle_roles, [:web, :app, :worker]

# Bundler
set :bundle_binstubs, false

# Rollbar
#set :rollbar_token, YAML.load_file("config/app.yml")['development']['rollbar']['server_token']

# Hooks
after "deploy:publishing", "deploy:restart"
