define users::user(
  $user_name = $name,
  $create_resource = true,
) {

  require users::config

  $user_info = lookup('users::user_info')[$user_name]

  $groups = $user_info['include_groups'] ? {
    undef   =>  $user_info['groups'],
    default => $user_info['include_groups']
  }

  $groups.each |$group| {
    include "groups::${group}"
  }

  $actual_name = pick(pick($user_info['puppet_options'], {})['name'], $user_name)

  $defaults = {
    'system'     => false,
    'managehome' => true,
    'shell'      => '/bin/bash',
    'ensure'     => 'present',
    'home'       => pick($user_info['puppet_options'], {})['managehome'] ? {
      false   => undef,
      default => "/home/${actual_name}"
    }
  }

  $puppet_options = merge($user_info['puppet_options'], {'groups' => $user_info['groups']})

  if ($create_resource) {
    create_resources(user, { $user_name => $puppet_options }, $defaults)
  }

  if ($user_info['authorized_users']) {
    $user_info['authorized_users'].each |$key| {
      $fetched_data = fetch_url("https://github.com/${key}.keys")
      $fetched_data.split("\n").each |$data| {
        ssh_authorized_key { "${user_name}-${key}-${data.split(' ')[1]}":
          ensure => present,
          user   => $user_name,
          type   => $data.split(' ')[0],
          key    => $data.split(' ')[1],
        }
      }
    }
  }
  if ($user_info['authorized_keys']) {
    $user_info['authorized_keys'].each |$data| {
      ssh_authorized_key { "${user_name}-${data.split(' ')[1]}":
        ensure => present,
        user   => $user_name,
        type   => $data.split(' ')[0],
        key    => $data.split(' ')[1],
      }
    }
  }

  $actual_options = $defaults.merge($puppet_options)
  if ($actual_options['managehome'] ) {
    bashrc::install { $user_name:
      home_dir  => $actual_options['home'],
      user_name => $actual_options['name'],
    }
  }
}
