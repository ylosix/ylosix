# Set the working application directory
# working_directory "/path/to/your/app"
working_directory '/var/www'

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"


# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"


if ENV['RAILS_PIDS'].nil? && ENV['RAILS_PIDS'] != ''
  pid ENV['RAILS_PIDS']
end

if ENV['RAILS_LOGS'].nil? && ENV['RAILS_LOGS'] != ''
  stderr_path ENV['RAILS_LOGS']
  stdout_path ENV['RAILS_LOGS']
end


# Unicorn socket
listen '/tmp/unicorn.sock'

# Number of processes
worker_processes 4

# Time-out
timeout 30
