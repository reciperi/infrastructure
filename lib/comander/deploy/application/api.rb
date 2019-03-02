# Config
set :application, 'api'
set :repo_url, 'git@github.com:reciperi/api.git'
set :deploy_to, -> { fetch(ENV['APP_PATH'], '/srv/app') }
set :linked_files, fetch(:linked_files, []).push('.env')

# TODO: remove maybe not needed
# Review we with need shared folder for a Phoenix app
set :linked_dirs, fetch(:linked_dirs, []).push('tmp/cache')

# TODO: Maybe this hook is necessary with an Elixir/Phoenix
# app. This was making deploy fail on devenv
# because we don't have sidekiq in this project.
# Remove if not necessary
# after 'deploy:starting', 'sidekiq:quiet'

# Hooks
after 'deploy:publishing', 'deploy:restart'

def shared_path
  Pathname.new('/srv/app/shared')
end
