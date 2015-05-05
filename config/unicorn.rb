# Set the working application directory
# working_directory "/path/to/your/app"
working_directory '/var/www'

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid '/home/vagrant/pids/unicorn.pid'

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path '/home/vagrant/logs/unicorn.log'
stdout_path '/home/vagrant/logs/unicorn.log'

# Unicorn socket
listen '/tmp/unicorn.sock'

# Number of processes
worker_processes 4

# Time-out
timeout 30
