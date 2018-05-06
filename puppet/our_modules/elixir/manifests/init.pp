# Elixir versions on Ubuntu can be found here:
# https://www.erlang-solutions.com/resources/download.html
#
class elixir (
  $erlang_repo_name,
  $erlang_repo_location,
  $erlang_repo_key,
  $elixir_version
) {
  include ::apt
  apt::source { $erlang_repo_name:
    location => $erlang_repo_location,
    repos    => 'contrib',
    key      => {
      'id' => $erlang_repo_key
    }
  }
  -> Class['apt::update']
  -> package { 'esl-erlang':
      ensure  => 'latest',
      require => Apt::Source[$erlang_repo_name]
  } -> package { 'elixir':
    ensure  => $elixir_version,
    require => Apt::Source[$erlang_repo_name]
  }
}
