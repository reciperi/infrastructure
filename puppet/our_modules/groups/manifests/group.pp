define groups::group(
  $group_name = $name,
) {

  require groups

  $group_info = lookup('groups::group_info')[$group_name]
  create_resources(group, { $group_name => $group_info['puppet_options'] })

  users::for_group { $group_name: }
}
