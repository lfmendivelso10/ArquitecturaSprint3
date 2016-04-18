# set path to application
# Sidekiq Global Configuration
#
require 'sidekiq'

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/tmp"
working_directory app_dir


# Set unicorn options
worker_processes 10
preload_app true
timeout 30

# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Logging
stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"

after_fork do |server, worker|

# In-Memory datastore
  redis_conn = proc {
    Redis.new
  }
# Server configuration por 102
  Sidekiq.configure_server do |config|
    config.redis = {url: 'redis://localhost:6379/12'}
    config.redis = ConnectionPool.new(size: 102, &redis_conn)

  end
# Client Configuration
  Sidekiq.configure_client do |config|
    config.redis = {url: 'redis://localhost:6379/12'}
    config.redis = ConnectionPool.new(size: 102, &redis_conn)
  end
end