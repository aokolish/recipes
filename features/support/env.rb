#not sure if I want to use simple cov w/these tests
#require 'simplecov'
#SimpleCov.start
ENV['RAILS_ENV'] ||= 'spinach'
require 'rack/test'
require 'factory_girl'
require 'spinach-rails'
require './config/environment'
require 'rspec/core'
require 'rspec/expectations'
require 'capybara/poltergeist'
require 'database_cleaner'
require 'fakeweb'
require 'pry'

begin
  require './spec/factories'
rescue FactoryGirl::DuplicateDefinitionError
  puts "factories already loaded"
end

support_files = Dir.glob(Rails.root.join("features/support/**/*.rb"))
common_steps = Dir.glob(Rails.root.join("features/steps/common_steps/**/*.rb"))

(support_files + common_steps).each do |f|
  require f
end

Capybara.javascript_driver = :poltergeist

DatabaseCleaner.strategy = :truncation

Spinach.hooks.before_run do |scenario_data|
  # TODO: change this to VCR or something so I can work offline
  response = `curl -is http://www.foodnetwork.com/recipes/ina-garten/strawberry-tarts-recipe/index.html`
  FakeWeb.register_uri(:get, "http://www.foodnetwork.com/example", :response => response)

  response = `curl -is http://www.cookingchanneltv.com/recipes/monkey-tail-banana-cake-recipe/index.html`
  FakeWeb.register_uri(:get, "http://www.cookingchanneltv.com/example", :response => response)
end

Spinach.hooks.around_scenario do |scenario_data, step_definitions, &block|
  DatabaseCleaner.start
  block.call
  DatabaseCleaner.clean
end
