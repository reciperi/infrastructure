class role::webserver {
  # Common tools (secondary)
  include profile::base

  # Important staff
  include profile::nginx
  include profile::elixir
}
