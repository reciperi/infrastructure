#site.pp
node 'default' {
  include role::webserver
}
