# Elixir versions on Ubuntu can be found here:
# https://www.erlang-solutions.com/resources/download.html
#
class elixir ($user) {
  include ::apt

  $erlang_repo_name = 'earlang-solutions'
  apt::source { $erlang_repo_name:
    location => 'http://packages.erlang-solutions.com/ubuntu',
    repos    => 'contrib',
    key      => {
      'id' => '434975BD900CCBE4F7EE1B1ED208507CA14F4FCA'
    }
  }

  Class['apt::update']
  -> package { 'esl-erlang':
    ensure  => 'latest',
    require => Apt::Source[$erlang_repo_name]
  }
  -> package { 'elixir':
    ensure  => '1.8.1-2',
    require => Apt::Source[$erlang_repo_name]
  }
  -> class { "${module_name}::phoenix":
    version => '1.4.2',
    user    => $user
  }

  contain("${module_name}::phoenix")
}
