# This puppet package is used here
# https://forge.puppet.com/puppetlabs/postgresql
#
class postgresql_server (
  $db_username,
  $db_password,
) {
  class { 'postgresql::server': }

  # Create a user based on hiera data
  postgresql::server::role { $db_username:
    password_hash       => $db_password,
    createdb            => true
  }
}
