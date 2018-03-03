require 'capistrano/consul'
require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
require_relative '../tasks'
install_plugin Capistrano::SCM::Git
require_relative 'overrides'
