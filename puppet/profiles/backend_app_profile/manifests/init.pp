# Stack for backend
class backend_app_profile (
  $user,
  $group,
) {
  require "users::${user}"
  class{'nginx':
    manage_repo    => true,
    package_source => 'nginx-mainline'
  }
  class { 'elixir': }
}
