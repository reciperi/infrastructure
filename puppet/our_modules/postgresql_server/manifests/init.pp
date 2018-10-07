# This puppet package is used here
# https://forge.puppet.com/puppetlabs/postgresql
#
class postgresql_server (
  $db_username,
  $db_password,
) {
  utils::env_vars {'postgresql_env_vars':
    module   => 'backend',
    lines => {
      db_username => $db_username,
      db_password => $db_password
    }
  }
  class { 'postgresql::server': }
  postgresql::server::role { $db_username:
    password_hash       => $db_password,
    createdb            => true
  }
}
