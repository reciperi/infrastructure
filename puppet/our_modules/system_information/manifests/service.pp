# system_information::service
class system_information::service {
  service { 'system_information':
    ensure => 'running',
    enable => true
  }
}
