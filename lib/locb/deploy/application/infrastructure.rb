# Config
set :application, 'infrastructure'
set :deploy_to, -> { ENV.fetch('APP_PATH', '/srv/infrastructure') }
set :user, 'ubuntu'

append :linked_dirs, 'arch/development/.vagrant'
