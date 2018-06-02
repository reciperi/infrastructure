# users
class users {
  anchor {"${module_name}::begin": } ->
  class  {"${module_name}::config": } ->
  anchor {"${module_name}::end": }
}
