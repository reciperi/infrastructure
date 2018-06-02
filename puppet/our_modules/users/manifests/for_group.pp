define users::for_group($group = $title, $user_info = lookup('users::for_group::user_info')) {
  users_for_group($group, $user_info).each |$user| {
    require "users::${user}"
  }
}
