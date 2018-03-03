Locb::CapistranoUtils.configure!(stage: 'staging')

server 'localhost', roles: %w(web app db), user: 'deploy'
set :stage, 'staging'
