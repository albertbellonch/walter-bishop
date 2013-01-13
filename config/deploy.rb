# RVM
set :rvm_ruby_string, "1.9.3"
set :rvm_type, :system
set :rvm_install_with_sudo, true

# Configuration
set :application, "walter_bishop"
set :keep_releases, 5
set :bundle_without, [:development, :test]

# Stages
set :stages, %w( production )
set :default_stage, "production"

# SCM
set :scm, :git
set :deploy_via, :remote_cache
set :repository, "git@github.com:albertbellonch/walter_bishop.git"

# Users
set :use_sudo, false
_cset :user, "deployer"

# Misc
set :config_files, ['config/database.yml']
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# Callbacks
after "deploy:update_code", "deploy:cleanup"
