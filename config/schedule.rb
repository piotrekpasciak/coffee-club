set :output, Whenever.path + '/log/cron.log'

set :environment, 'production' if @environment.nil?

case @environment
  when 'production'
    set :bundle_command, "/home/aligator/.rvm/gems/ruby-2.2.0/bin/rake"
    job_type :rake, "cd :path && :environment_variable=:environment /home/aligator/.rvm/gems/ruby-2.2.0/bin/rake :task --silent :output"
  when 'development'
    set :bundle_command, "/home/ppasciak/.rbenv/shims/bundle"
    job_type :rake, "cd :path && :environment_variable=:environment /home/ppasciak/.rbenv/shims/rake :task --silent :output"
  else
    set :bundle_command, "/home/ppasciak/.rbenv/shims/bundle"
    job_type :rake, "cd :path && :environment_variable=:environment /home/ppasciak/.rbenv/shims/rake :task --silent :output"
end

every 2.minutes, roles: [:app] do
  command 'echo "Events without time got expired."'
  rake "cron:expire_old_open_events"
end
