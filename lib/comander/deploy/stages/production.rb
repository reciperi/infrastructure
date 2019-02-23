# TODO: implement production deploy
GATEWAY_HOST = 'gateway.example.com'.freeze

Comander::CapistranoUtils.configure!

set(
  :ssh_options,
  proxy: Net::SSH::Proxy::Command.new("ssh deploy@#{GATEWAY_HOST} -W %h:%p"),
  user: fetch(:user, 'deploy'),
  forward_agent: true,
  auth_methods: %w[publickey],
  verify_host_key: false
)
