class comander {

  $comander_dir = "${::puppet_path}/../.."
  $comander_cmd = "${comander_dir}/bin/comander"

  require packages::build_essential
  require packages::git
  require packages::libcurl4_openssl_dev

  $bundler_cmd = has_key($facts, 'bundler_path')? {
    true    => $::bundler_path,
    default => '/usr/local/bin/bundler'
  }

  exec { "${bundler_cmd} install":
    cwd    => $comander_dir,
    unless => "${bundler_cmd} check --gemfile ${comander_dir}/Gemfile",
  }

}
