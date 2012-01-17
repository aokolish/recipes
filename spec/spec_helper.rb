require 'rubygems'
require 'database_cleaner'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.filter_run_excluding :broken => true

  Capybara.javascript_driver = :webkit

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    if example.metadata[:js]
      #config.use_transactional_fixtures = false
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end
  end

  config.after(:each) do
    Capybara.use_default_driver if example.metadata[:js]
    DatabaseCleaner.clean
    #config.use_transactional_fixtures = true
  end

  # cache external pages for use in various tests
  response = `curl -is http://www.foodnetwork.com/recipes/strawberries-and-cream-tart-recipe/index.html`
  FakeWeb.register_uri(:get, "http://www.foodnetwork.com/example", :response => response)

  response = `curl -is http://www.cookingchanneltv.com/recipes/monkey-tail-banana-cake-recipe/index.html`
  FakeWeb.register_uri(:get, "http://www.cookingchanneltv.com/example", :response => response)

end
