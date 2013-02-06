require 'rubygems'
require 'spork'

Spork.prefork do
  require 'database_cleaner'

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include(UserMacros)
    config.mock_with :rspec

    # stop on the first failure
    config.fail_fast = true
    config.use_transactional_fixtures = false

    Capybara.javascript_driver = :webkit

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # cache external pages for use in various tests
    response = `curl -is http://www.foodnetwork.com/recipes/strawberries-and-cream-tart-recipe/index.html`
    FakeWeb.register_uri(:get, "http://www.foodnetwork.com/example", :response => response)

    response = `curl -is http://www.cookingchanneltv.com/recipes/monkey-tail-banana-cake-recipe/index.html`
    FakeWeb.register_uri(:get, "http://www.cookingchanneltv.com/example", :response => response)
  end

  # helper to get all images for specs
  def images
    images = Dir.entries(Rails.root.to_s + '/spec/images')
    images.reject(&File.method(:directory?))
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  FactoryGirl.reload
end

