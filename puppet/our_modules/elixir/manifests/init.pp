# Elixir versions on Ubuntu can be found here:
# https://www.erlang-solutions.com/resources/download.html
#
class elixir (
  $version
) {
  package { 'elixir':
    ensure => $version
  }
}
