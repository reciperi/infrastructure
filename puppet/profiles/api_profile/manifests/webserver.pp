# Nginx configuration for Phoenix app
class api_profile::webserver (
  $upstream_port,
  $server_name
) {

  # FIXME:
  # Move this to a module. We will want to this too
  # for Node app and I think it will fail if we define this class
  # twice
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
