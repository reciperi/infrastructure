# Stack for api
class api_profile (
  $deploy_directory,
  $user,
  $group,
  $branch
) {
  require system_information
  require "users::${user}"
  class { 'database': }
  class { 'elixir':
    user => $user
  }

  comander::deploy { 'api':
    app_name => 'api',
    branch   => $branch,
    creates  => "${deploy_directory}/current",
  }

  class { "${module_name}::webserver":
    upstream_port => $system_information::roles['api']['upstream_port'],
    server_name   => $system_information::roles['api']['server_name'],
  }

  $directories = [
    $deploy_directory,
    "${deploy_directory}/shared"
  ]

  # Ensure needed directory structure for the project is there
  file { $directories:
    ensure => 'directory',
    mode   => '0770',
    owner  => $user,
    group  => $group,
  }
}
