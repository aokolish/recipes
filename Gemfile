source 'http://rubygems.org'

gem 'rails', '~> 3.2.0'
gem 'nokogiri'
gem 'chronic_duration'
gem 'jquery-rails'
gem 'will_paginate'
gem 'simple_form'
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'escape_utils'
gem 'haml'
gem 'simple-navigation'
gem 'bourbon'
gem 'rmagick'
gem 'carrierwave'
gem 'fog'
gem 'decent_exposure'
gem 'best_in_place'
gem 'acts_as_list'
gem 'foreman'
gem 'bootstrap-sass', '~> 2.1.0'
gem "rspec-rails" # => cannot be in test group because it breaks rake on heroku

group :development, :test do
  gem "nifty-generators"
  gem 'localtunnel'
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'thin'

  # debugging
  gem 'pry'
end

group :test do
  gem 'simplecov', :require => false
  #gem 'simplecov', :require => false , :path => '~/code/gems/simplecov/'
  gem "capybara"
  gem "poltergeist"
  gem 'launchy'
  gem 'database_cleaner'
  gem 'ruby_gntp'
  gem "fakeweb"
  gem "rb-fsevent"
  gem "spinach-rails"
  gem 'pg'
end

group :assets do
  gem 'sass-rails', "  ~> 3.2.5"
  gem "sass", :github => "nex3/sass", :branch => 'master'
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
  gem 'newrelic_rpm'
  gem 'unicorn'
end
