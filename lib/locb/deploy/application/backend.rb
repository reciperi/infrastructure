# Config
set :application, 'backend'
set :repo_url, 'git@github.com:locbadge/backend.git'
set :deploy_to, -> { fetch(ENV['APP_PATH'], '/srv/app') }
set :linked_files, fetch(:linked_files, []).push('.env')
# TODO: remove maybe not needed
set :linked_dirs, fetch(:linked_dirs, []).push('tmp/cache')

# Hooks
after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:publishing', 'deploy:restart'

def shared_path
  Pathname.new('/srv/app/shared')
end
