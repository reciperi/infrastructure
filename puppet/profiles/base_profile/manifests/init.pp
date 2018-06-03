# common packages we want in all nodes
class base_profile {
  class { 'vim': }

  class { 'timezone':
    timezone => 'Etc/UTC'
  }
}
