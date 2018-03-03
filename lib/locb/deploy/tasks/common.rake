task :invoke do
  fail 'no task provided' unless ENV['COMMAND']

  on roles(:app) do
    within release_path do
      # FIXME: Change this. Not using Rails
      # with rails_env: fetch(:rails_env) do
      #   execute ENV['COMMAND'].split(' ')[0], *ENV['COMMAND'].split(' ')[1..-1]
      # end
    end
  end
end
