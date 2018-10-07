Locb::CapistranoUtils.configure!(stage: 'development')

server(
  'localhost',
  user: fetch(:user, 'deploy'),
  roles: %w[web app db],
  ssh_options: {
    user: fetch(:user, 'deploy'), # overrides user setting above
    forward_agent: true,
    auth_methods: %w[publickey]
  }
)

set :stage, 'development'
set :bundle_without, nil
set :format_options, log_file: ENV.fetch('CAP_LOG_FILE', 'log/capistrano.log')
