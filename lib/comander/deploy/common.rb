require 'socket'

module Comander
  class CapistranoUtils
    class <<self
      def configure!(application: fetch(:application), stage: fetch(:stage))
        # Define common variables
        called_stage = fetch(:stage)
        set :stage, stage
        set :branch, ENV.fetch('BRANCH', 'master')
        set(
          :format_options,
          log_file: ENV.fetch('CAP_LOG_FILE', 'log/capistrano.log')
        )

        # load specific configuration depending on the stage/application
        any_stage_config_file = "#{__dir__}/application/#{application}/common.rb"
        stage_config_file = "#{__dir__}/application/#{application}/#{called_stage}.rb"
        tasks_config_file = "#{__dir__}/application/#{application}/tasks.rb"
        require any_stage_config_file if File.exist?(any_stage_config_file)
        require stage_config_file if File.exist?(stage_config_file)
        require tasks_config_file if File.exist?(tasks_config_file)
      end

      def free_port(port = 8500)
        begin
          server = TCPServer.new('127.0.0.1', port)
        rescue Errno::EADDRINUSE
          port = rand(65000 - 1024) + 1024
          retry
        end
        begin
          server.close
        rescue => _
        end
        port
      end
    end
  end
end
