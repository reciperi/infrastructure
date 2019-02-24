class backend_app_profile::webserver (
  $upstream_port,
  $server_name
) {
  class {'nginx':
    manage_repo    => true,
    package_source => 'nginx-mainline'
  }
  nginx::resource::upstream { 'api_app':
    members => {
      "localhost:${upstream_port}" => {
        server => 'localhost',
        port   => $upstream_port,
        weight => 1,
      }
    }
  }

  nginx::resource::server { $server_name:
    proxy => 'http://api_app',
  }
}
