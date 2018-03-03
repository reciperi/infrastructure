Locb::CapistranoUtils.configure!

server 'staging.locb.xyz',
  user: fetch(:user, 'deploy'),
  roles: %w{web app db worker},
  ssh_options: {
    forward_agent: true,
    auth_methods: %w(publickey)
  }

set :format_options, log_file: ENV.fetch('CAP_LOG_FILE', 'log/capistrano.log')
