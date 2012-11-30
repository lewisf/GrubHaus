source 'https://rubygems.org'

gem 'rails', '3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mongoid', '~> 3.0.0'
gem 'devise'
gem 'fog', "~> 1.3.1"
gem 'requirejs-rails'
gem 'heroku'
gem 'haml-rails'
gem 'carrierwave'
gem 'carrierwave-mongoid'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'compass-rails', '~> 1.0.0.rc.2'
  gem 'compass-colors'
  gem 'compass-960-plugin'
  gem 'sassy-buttons'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'spork-rails'
  gem 'rspec-rails', '~> 2.0'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'terminal-notifier-guard'
  gem 'foreman'
  gem 'colorize'
  gem 'faker'
end

group :test do
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
  gem 'factory_girl_rails'
  gem 'mongoid-rspec'
end

gem 'jquery-rails'

group :production do
  gem 'thin'
  gem 'haml'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
