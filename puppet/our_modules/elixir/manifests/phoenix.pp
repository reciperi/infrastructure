# Phoenix documentation
# Install phonix package and dependencies
# https://hexdocs.pm/phoenix/up_and_running.html
#
class elixir::phoenix (String $version, String $user) {
  $paths = ['/bin', '/usr/bin', '/usr/local/bin']
  $environment = ["HOME=/home/${user}"]

  exec { 'install_hex':
    command     => 'mix local.hex --force',
    returns     => [0, 1],
    path        => $paths,
    user        => $user,
    environment => $environment,
  }
  -> elixir::package_uninstall { 'phx_new':
    paths       => $paths,
    new_version => $version,
    environment => $environment,
    user        => $user
  }
  -> exec { 'phoenix_install':
    command     => "mix archive.install hex phx_new ${version} --force",
    path        => $paths,
    returns     => [0, 1],
    environment => $environment,
    user        => $user
  }
}
