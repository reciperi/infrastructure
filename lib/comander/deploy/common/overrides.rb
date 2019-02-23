# If GIT_OVERRIDE_RELEASE_CREATE_PATH ENV var is set
# Instead of using git repo to create the release branch, we upload a tarfile
if ENV.key?('GIT_OVERRIDE_RELEASE_CREATE_PATH')
  namespace :git do
    Rake::Task['create_release'].clear_actions

    desc 'Copy repo to releases'
    task create_release: :'git:update' do
      on release_roles :all do
        with fetch(:git_environmental_variables) do
          temp_file = "/tmp/#{fetch(:application)}-#{fetch(:stage)}-#{fetch(:branch).gsub('/', '_')}.tgz"
          upload! ENV.fetch('GIT_OVERRIDE_RELEASE_CREATE_PATH'), temp_file
          execute :mkdir, '-p', release_path
          within release_path do
            execute :tar, '-xvzf', temp_file, '.'
          end
        end
      end
    end
  end
end
