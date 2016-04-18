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

before_fork do |server, worker|
  @sidekiq_pid ||= spawn('bundle exec sidekiq -c 2')
end

after_fork do |server, worker|
  Sidekiq.configure_client do |config|
    config.redis = { :size => 100 }
  end
  Sidekiq.configure_server do |config|
    config.redis = { :size => 100 }
  end
end