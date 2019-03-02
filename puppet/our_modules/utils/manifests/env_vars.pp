define utils::env_vars (
  $module,
  $lines
) {
  $modules = {
    api => lookup('api_profile::deploy_directory')
  }
  $user = lookup('api_profile::user')
  $module_path = $modules[$module]
  $env_file = "${module_path}/shared/.env"

  unless defined(File["${$env_file}"]) {
    file { $env_file:
      ensure => present,
      mode   => '0644',
      owner  => $user
    }
  }

  $lines.each |$env_key, $env_value| {
    file_line { "${module}_${env_key}_env_file":
      ensure            => present,
      path              => $env_file,
      line              => "export ${env_key.upcase}=${env_value}",
      match             => "^export ${env_key.upcase}=",
      match_for_absence => true,
    }
  }
}
