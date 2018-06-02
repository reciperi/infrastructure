# Stack for backend
class profile::backend_app {
  class{'nginx':
    manage_repo    => true,
    package_source => 'nginx-mainline'
  }
  class { 'elixir': }
}
