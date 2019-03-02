define comander::command(
  $options,
  $creates,
  $refreshonly,
  $environment_extra,
)
{
  require comander

  exec { $name:
    command     => "/usr/bin/env ${comander::comander_cmd} ${options}",
    creates     => $creates,
    refreshonly => $refreshonly,
    environment => $environment_extra,
    timeout     => 0,
  }

}
