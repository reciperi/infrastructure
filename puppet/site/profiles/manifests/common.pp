class profiles::common {
  # common users
  users { 'common': }

  # sshd config
  include profiles::ssh::server

  # common packages needed everywhere
  package {['vim', 'sudo']:
    ensure => present
  }

  # set locale
  class { 'locales':
    default_locale => 'en_US.UTF-8',
    locales        => ['en_US.UTF-8 UTF-8']
  }
}
