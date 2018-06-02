# common packages we want in all nodes
class profile::base {
  class { 'vim': }

  # This is failing error:
  # `vagrant` user do not have sudo permissions
  class { 'timezone':
    timezone => 'Etc/UTC'
  }
}
