define comander::deploy (
  $branch,
  $app_name = $title,
  $environment_extra = [],
  $creates = undef,
  $refreshonly = undef,
)
{
  # THIS IS WRONG
  $to = (!$::subenvironment) ? {
    ''      => "${environment}_localhost",
    default => "${environment}_${::subenvironment}_localhost"
  }

  comander::command { "deploy ${app_name} ${branch} for ${name}":
    options           => "deploy ${app_name} -t ${to} -b ${branch}",
    creates           => $creates,
    refreshonly       => $refreshonly,
    environment_extra => $environment_extra,
  }

}
