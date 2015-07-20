workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RAILS_ENV'] || 'development'

if !ENV['RAILS_PIDS'].nil? && ENV['RAILS_PIDS'] != ''
  pidfile ENV['RAILS_PIDS']
end

if !ENV['RAILS_LOGS'].nil? && ENV['RAILS_LOGS'] != ''
  stdout_redirect ENV['RAILS_LOGS'], ENV['RAILS_LOGS']
end

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
