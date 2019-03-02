class packages::build_essential {
  package { 'build-essential':
    ensure => 'latest'
  }
}
