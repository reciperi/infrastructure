define bashrc::install(
  $user_name = $title,
  $home_dir = "/home/${user_name}",
  $ps1_ansi_color_number = lookup('bashrc::ps1_ansi_color_number'),
  $include_bash_interactive_files = lookup('bashrc::include_bash_interactive_files'),
)
{

  file { "${home_dir}/.bashrc":
    ensure  => file,
    mode    => '0644',
    owner   => $user_name,
    content => template("${module_name}/.bashrc.erb"),
  }

  file { ["${home_dir}/.bashrc_not_interactive.d", "${home_dir}/.bashrc.d"]:
    ensure => 'absent',
    force  => true,
  }

}
