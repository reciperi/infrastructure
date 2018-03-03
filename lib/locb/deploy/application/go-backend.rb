require_relative '../common/rails_app'

# Config
set :application, 'go-backend'
set :repo_url, 'git@github.com:locbadge/go-backend.git'
set :deploy_to, -> { fetch(ENV['APP_PATH'], '/srv/app') }
set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.env')
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets'
)

# Hooks
after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:publishing', 'deploy:restart'

# Do not symlink assets
namespace :deploy do
  task :remove_linked_dirs do
    remove :linked_dirs, "public/assets"
  end
end
after 'deploy:set_linked_dirs', 'deploy:remove_linked_dirs'

def shared_path
  Pathname.new('/srv/app/shared')
end
