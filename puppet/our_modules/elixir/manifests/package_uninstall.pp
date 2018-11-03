# Package unistall on Elixir archive
define elixir::package_uninstall (
  $paths,
  $new_version,
  $environment,
  $user
) {
  # Get old package version
  # Fucking bash escaping especial grep regex chars
  $dash = '\-'
  $number = '\d{0,2}\.\d{0,2}\.\d{0,2}(\-rc\.\d{0,2}){0,1}$'

  $old_package = "mix archive | grep -oP '${name}${dash}${number}'"
  $old_version = "${old_package} | grep -oP '${number}'"
  $version_changed = "test \"\$(${old_version})\" != '' && test \"\$(${old_version})\" != ${new_version}"

  exec { "message_before_uninstall_${name}":
    command     => "echo Uninstalling \"\$(${old_package})\"",
    path        => $paths,
    logoutput   => true,
    onlyif      => $version_changed,
    environment => $environment
  }
  -> exec { "uninstall_${name}":
    command     => "mix archive.uninstall \"\$(${old_package})\" --force",
    path        => $paths,
    logoutput   => false,
    environment => $environment,
    onlyif      => $version_changed,
    returns     => [0, 1],
    user        => $user
  }
}
