ENV['RAILS_ENV'] ||= 'spinach'
require 'rack/test'
require 'factory_girl'
require 'spinach-rails'
require './config/environment'
require 'rspec/core'
require 'rspec/expectations'
require 'capybara/poltergeist'
require 'database_cleaner'
require 'pry'
require 'vcr'

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

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes }
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  if ENV['WITHOUT_VCR']
    config.default_cassette_options = {record: :all}
    puts "VCR: ignoring all cassettes"
  end
end

Spinach.hooks.around_scenario do |scenario_data, step_definitions, &block|
  DatabaseCleaner.start
  block.call
  DatabaseCleaner.clean
end

Spinach.hooks.before_scenario do |scenario|
  VCR.insert_cassette(scenario.name.parameterize)
end

Spinach.hooks.after_scenario do
  VCR.eject_cassette
end
