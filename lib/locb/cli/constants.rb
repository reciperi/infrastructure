module Locb
  module CLI
    INFRASTRUCTURE_BASE_DIR = File.expand_path("#{__dir__}/../../../")
    PUPPET_PATH = File.expand_path("#{INFRASTRUCTURE_BASE_DIR}/puppet")
    ANSIBLE_PATH = File.expand_path("#{INFRASTRUCTURE_BASE_DIR}/ansible")
    PRIVATE_KEY_FILE = File.expand_path(
      "#{INFRASTRUCTURE_BASE_DIR}/puppet/keys/private_key.pkcs7.pem"
    )
    REPOS_DIRECTORY = File.expand_path("#{INFRASTRUCTURE_BASE_DIR}/cache/repos")
    BIN_CACHE_DIRECTORY = File.expand_path(
      "#{INFRASTRUCTURE_BASE_DIR}/cache/bin"
    )
    DEVENV_IP = '10.0.4.3'.freeze
    HOSTS = 'dev.efood.me'.freeze
  end
end
