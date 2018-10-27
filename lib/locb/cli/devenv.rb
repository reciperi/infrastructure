module Locb
  module CLI
    class Devenv < Thor
      desc 'up', 'Starts the devenv environment (this is a alias of vagrant devenv up)'
      def up
        invoke 'locb:c_l_i:base:vagrant', ['devenv', 'up']
      end

      desc 'exec_command COMMAND', 'Runs a command inside the devenv environment'
      def exec_command(*command)
        system("cd #{INFRASTRUCTURE_BASE_DIR}/devenv && vagrant ssh develop -c '#{command.join(' ')}'")
      end

      desc 'ssh', 'Sshs into the devenv environment'
      def ssh
        invoke 'locb:c_l_i:base:vagrant', ['devenv', 'ssh']
      end

      desc 'provision', 'Provisions the devenv environment'
      def provision
        exec_command('sudo apt-get update')
        invoke 'locb:c_l_i:base:vagrant', ['devenv', ['provision']]
      end

      desc 'reload', 'Reloads the devenv environment'
      def reload
        invoke 'locb:c_l_i:base:vagrant', ['devenv', ['reload']]
      end

      desc 'halt', 'Halts the devenv environment'
      def halt
        invoke 'locb:c_l_i:base:vagrant', ['devenv', ['halt']]
      end

      desc 'destroy', 'destroys the devenv environment'
      def destroy
        invoke 'locb:c_l_i:base:vagrant', ['devenv', ['destroy']]
      end

      desc 'start_servers', 'Starts servers inside devenv in foreground'
      # FIXME: This is not working because there is notthing to be run
      # Once golang project is setup with nginx check how raun it
      def start_servers
        exec_command('cd /home/infrastructure/ && tmuxinator')
      end
    end
  end
end
