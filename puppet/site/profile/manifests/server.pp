class profile::server {
  class{'nginx':
    manage_repo    => true,
    package_source => 'nginx-mainline'
  }
}
