require 'thor'
require_relative '../locb'
require_relative 'cli/constants'
require_relative 'cli/setup'
require_relative 'cli/devenv'
require_relative 'cli/utils'

def ansible_playbooks
  Dir.glob("#{Locb::CLI::ANSIBLE_PATH}/*yml").map do |i|
    i.split('/').last.split('.').first
  end
end

module Locb
  module CLI
    class Base < Thor
      register(
        Setup,
        'setup', 'setup', 'Sets up this cli (installs requirements)'
      )
      register(
        Devenv,
        'devenv', 'devenv', 'Manage development environment for developers'
      )

      desc 'bootstrap IP', 'Bootstraps a server'
      method_option(:env, aliases: '-e', default: 'staging', desc: 'The environment of the server')
      method_option(:subenv, aliases: '-s', desc: 'The subenvironment of the server')
      method_option(:hostname, aliases: '-h', desc: 'The target hostname (will be set)')
      method_option(:domain, aliases: '-d', default: 'locb.xyz', desc: 'The target domain (will be set)')
      method_option(:user, aliases: '-u', default: 'ubuntu', desc:  'The user used to connect')
      method_option(:bastion_host, aliases: '-b', desc: 'A bastion host to use to get into the server')
      method_option(:ask_password, aliases: '-k', default: false, type: :boolean, desc: 'Ask for password')
      method_option(:identity_file, aliases: '-i', desc: 'Private key for connecting')
      method_option(:private_key, desc: 'Private key for connecting in base64 online format (cat KEY_FILE|base64 -w )')
      def bootstrap(ip)
        setup_agent!(options[:identity_file], options[:private_key])
        check_ssh_agent!
        password_command = '-kK' if options[:ask_password]
        command = "cd #{ANSIBLE_PATH} ; ansible-playbook -i #{ip}, puppet.yml -c ssh  -u #{options[:user]} #{ssh_extra_args} #{password_command} --extra-vars \"set_hostname=#{options[:hostname]} set_domain=#{options[:domain]} set_environment=#{options[:env]} set_subenvironment=#{options[:subenv]} set_puppet_environment=#{options[:env]}\""
        puts command
        system(command)
        exit $?.exitstatus
      end

      desc 'deploy APP_NAME', 'Deploys APP_NAME into an environment'
      method_option(
        :to,
        aliases: '-t',
        default: 'staging',
        desc: 'The environment to deploy to'
      )
      method_option(
        :branch,
        aliases: '-b',
        default: 'master',
        desc: 'The branch to deploy'
      )
      method_option :private_key, desc: 'Private key for connecting'
      def deploy(app_name)
        setup_agent!(options[:identity_file], options[:private_key])
        check_ssh_agent!
        Locb::Deploy
          .new(application: app_name)
          .run!(
            options[:to],
            options[:branch],
            'deploy'
          )
      end

      desc 'rollback APP_NAME', 'Rolls back APP_NAME'
      method_option :to, aliases: '-t', default: 'staging', desc: 'The environment to deploy to'
      def rollback(app_name)
        Locb::Deploy
          .new(application: app_name)
          .run!(
            options[:to],
            nil,
            'deploy:rollback'
          )
      end

      desc 'capistrano APP_NAME', 'Runs a capistrano task'
      method_option :environment, aliases: '-e', default: 'staging', desc: 'The capistrano environment'
      method_option :branch, aliases: '-b', default: 'master', desc: 'The branch to deploy'
      method_option :task, aliases: '-t', default: 'deploy', desc: 'The task to run'
      method_option :tasks, aliases: '-T', desc: 'Show available tasks'
      method_option :private_key, desc: 'Private key for connecting in base64 online format (cat KEY_FILE|base64 -w )'
      def capistrano(app_name, *command)
        setup_agent!(options[:identity_file], options[:private_key])
        check_ssh_agent!
        Locb::Deploy
          .new(application: app_name)
          .run!(
            options[:environment],
            options[:branch],
            options[:task]
          )
      end

      desc 'ansible PLAYBOOK', 'executes an ansible playbook in an environment', hide: true
      method_option(
        :environment,
        aliases: '-e', default: 'development', desc: 'The ansible environment', enum: ansible_playbooks
      )
      def ansible(playbook)
        system('sudo ls > /dev/null') # Ensure we can run sudo passwordless
        puts `cd #{ANSIBLE_PATH} && pwd && ansible-playbook #{playbook}.yml -c local`
      end

      desc 'vagrant ENVIRONMENT *COMMAND', 'Execs a vagrant command in a given environment', hide: true
      def vagrant(env, *command)
        system(
          [
            "cd #{INFRASTRUCTURE_BASE_DIR}/arch/#{env} &&",
            "vagrant #{command.join(' ')}"
          ].join(' ')
        )
      end

      no_tasks do
        def ssh_extra_args
          bastion_host = "-o ControlPersist=15m  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A #{options[:user]}@#{options[:bastion_host]} -W %h:%p\"" if options[:bastion_host]
          "--ssh-extra-args='-A #{bastion_host}'"
        end
      end
    end
  end
end
