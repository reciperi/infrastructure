#site.pp
node 'develop' {
  include roles::www
}
