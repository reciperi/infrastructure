namespace 'puppet' do
  task 'apply' do
    on roles(:all) do
      within "#{release_path}/puppet" do
        begin
          execute :sudo, 'chown', fetch(:user), '-R', "#{release_path}/.."
          execute :sudo, 'apt-get', 'update'
          with facter_subenvironment: fetch(:substage, nil) do
            execute :sudo, '-E', 'puppet', 'apply', "environments/#{fetch(:stage)}/manifests/servers.pp", '--confdir', '.', "--environment=#{fetch(:stage)}", '--show_diff'
          end
        ensure
          execute :sudo, 'chown', fetch(:user), '-R', '.'
        end
      end
    end
  end
end

namespace 'deploy' do
  task 'copy_files' do
    on roles(:all) do
      within release_path do
        upload! File.expand_path("#{__dir__}/../../../../../puppet/keys/private_key.pkcs7.pem"), "#{release_path}/puppet/keys/private_key.pkcs7.pem"
      end
    end
  end
end

# Hooks
after 'deploy:published', 'deploy:copy_files'
after 'deploy:copy_files', 'puppet:apply'
