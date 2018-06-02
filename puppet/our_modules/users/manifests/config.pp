# users::config
class users::config {

  file { ['/etc/profile_not_interactive.d']:
    ensure => 'directory',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

}
