Locb::CapistranoUtils.configure!

server(
  'dev.reciperi.com',
  user: fetch(:user, 'deploy'),
  roles: %w[web app db],
  ssh_options: {
    user: fetch(:user, 'deploy'), # overrides user setting above
    forward_agent: true,
    auth_methods: %w[publickey]
  }
)

set :bundle_without, nil
