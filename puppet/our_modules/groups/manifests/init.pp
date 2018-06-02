# groups
class groups {
  anchor {"${module_name}::begin": } ->
  class  {"${module_name}::config": } ->
  anchor {"${module_name}::end": }
}
