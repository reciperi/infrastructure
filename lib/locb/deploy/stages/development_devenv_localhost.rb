require_relative 'development_localhost'
# This is a special case of a development localhost deploy
# it is intended for being able to use capistrano even though we already have the code
# local. This is the case with the devenv. In this situation the code is not taken
# from github but is already mounted in the server (a shared folder from the host).
# In such situation, we would like to perform the whole capistrano symlinking/compiling/etc
# but we skip the part the code is downloaded
server(
  'localhost',
  user: fetch(:user, 'vagrant'),
  roles: %w[web app db],
  ssh_options: {
    forward_agent: true,
    auth_methods: %w[publickey],
    known_hosts: Net::SSH::KnownHosts
  }
)

set :substage, 'devenv'
set :bundle_without, nil
set :bundle_flags, nil
set :bundle_jobs, 2

# We say that the release we are working in is the mounted dir
def release_path
  Pathname.new("#{fetch(:deploy_to)}/releases/devenv")
end

# We clear actions related to code fetching and release maintenance
namespace :git do
  Rake::Task['check'].clear_actions
  Rake::Task['update'].clear_actions
  Rake::Task['wrapper'].clear_actions
  Rake::Task['create_release'].clear_actions
  Rake::Task['set_current_revision'].clear_actions
  Rake::Task['clone'].clear_actions
end

namespace :deploy do
  Rake::Task['set_previous_revision'].clear_actions
  Rake::Task['restart'].clear_actions # We do not restart in devenv
  # Fetch the repo if it does not exists
  namespace :check do
    desc 'Check shared and release directories exist'
    task :directories do
      on release_roles :all do
        execute :mkdir, '-p', shared_path, releases_path, release_path
        unless test "[ -d #{release_path}/.git ]"
          execute :git, 'clone', fetch(:repo_url), release_path
        end
      end
    end
  end
end
