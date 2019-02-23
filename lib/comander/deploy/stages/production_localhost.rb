Comander::CapistranoUtils.configure!(stage: 'production')

server 'localhost',
  user: fetch(:user, ENV.fetch('CAP_USER', 'deploy')),
  roles: %w[web app db],
  ssh_options: {
    user: fetch(:user, 'deploy'), # overrides user setting above
    forward_agent: true,
    auth_methods: %w(publickey),
    verify_host_key: false
  }
