source 'http://rubygems.org'

##### App Dependencies #####
# AWS SDK
gem 'aws-sdk', '~> 2'
# Sidekiq and Redis
gem 'sidekiq'
gem 'sinatra', :require => nil
# Server Config
gem 'thin'
# Job Scheduler
gem 'rufus-scheduler'
gem 'newrelic_rpm'
##### End Dependencies #####

##### Functional Core
# Core
gem 'rails', '4.2.5.2'
# MariaDB-Mysql as the database for Active Record
gem 'mysql2', '>= 0.3.13', '< 0.5'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end