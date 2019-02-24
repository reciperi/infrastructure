# Stack for backend
class backend_app_profile (
  $deploy_directory,
  $user,
  $group,
) {
  require system_information
  require "users::${user}"
  class { 'database': }
  class { 'elixir':
    user => $user
  }
  class { "${module_name}::webserver":
    upstream_port => $system_information::roles['api']['upstream_port'],
    server_name   => $system_information::roles['api']['server_name'],
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
