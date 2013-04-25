require 'rubygems'
require 'simplecov'
require 'database_cleaner'
require 'vcr'

def zeus_running?
  File.exists? '.zeus.sock'
end

if !zeus_running?
  SimpleCov.start
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include(UserMacros)
  config.mock_with :rspec
  config.fail_fast = true
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Capybara.javascript_driver = :webkit

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes }
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  if ENV['WITHOUT_VCR']
    config.default_cassette_options = {record: :all}
    puts "VCR: ignoring all cassettes"
  end
end


# helper to get all images for specs
def images
  images = Dir.entries(Rails.root.to_s + '/spec/images')
  images.reject(&File.method(:directory?))
end
