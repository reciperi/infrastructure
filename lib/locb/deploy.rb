require 'open3'
require 'capistrano/all'
require_relative '../locb'
require_relative 'deploy/common'

module Locb
  # This class is to encapsulate capistrano logic
  # is intended to be used to deploy applications programatically
  class Deploy
    attr_accessor :options

    # Initializes the deploy
    #
    # @param [Hash] options
    # @option options :application The application to be deployes
    # @return and instance of Locb::Deploy
    def initialize(options)
      @options = options
      add_capistrano_extensions!
    end

    # Performs the deploy
    #
    # @param [String] environment The deploy stage
    # @return true if successful
    def run!(environment, branch, task = 'deploy', options = {})
      # Do the actual deploy
      load_capfile
      Rake.application.options.trace = false

      ENV['BRANCH'] = branch
      Rake::Task[environment].invoke
      Rake::Task[task].invoke
    end

    private

    def load_capfile
      load File.expand_path("#{File.dirname(__FILE__)}/deploy/application/#{options[:application]}/Capfile")
    end

    # Configures capistrano to use the desired application
    # This is a bit hacky, because we need to redefine some internal methods
    def add_capistrano_extensions!
      app_name = options[:application]
      # Here we rewrite the methods that capistrano uses
      # for locating the Capfile and the deploy files because
      # we use a multi application approach.
      Capistrano::DSL::Paths.send(:define_method, :stage_config_path) do
        Pathname.new fetch(:stage_config_path, File.expand_path("#{File.dirname(__FILE__)}/deploy/stages"))
      end

      Capistrano::DSL::Paths.send(:define_method, :deploy_config_path) do
        Pathname.new fetch(:deploy_config_path, File.expand_path("#{File.dirname(__FILE__)}/deploy/application/#{app_name}.rb"))
      end

      Capistrano::Application.send(:define_method, :capfile) do
        File.expand_path("#{File.dirname(__FILE__)}/deploy/application/#{app_name}/Capfile")
      end
    end
  end
end
