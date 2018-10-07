# Stack for backend
class backend_app_profile (
  $deploy_directory,
  $user,
  $group,
) {
  require "users::${user}"
  class { 'postgresql_server': }
  class { 'elixir': }
  class{'nginx':
    manage_repo    => true,
    package_source => 'nginx-mainline'
  }

  $directories = [
    $deploy_directory,
    "${deploy_directory}/shared",
    "${deploy_directory}/shared/tmp",
    "${deploy_directory}/shared/tmp/cache"
  ]

  # Ensure needed directory structure for the project is there
  file { $directories:
    ensure => 'directory',
    mode   => '0770',
    owner  => $user,
    group  => $group,
  }
}
