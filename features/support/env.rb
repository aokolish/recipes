ENV['RAILS_ENV'] ||= 'spinach'
require 'rack/test'
require 'factory_girl'
require 'spinach-rails'
require './config/environment'
require './spec/factories'
require 'rspec/core'
require 'rspec/expectations'
require 'spinach/capybara'
require 'database_cleaner'

support_files = Dir.glob(Rails.root.join("features/support/**/*.rb"))
common_steps = Dir.glob(Rails.root.join("features/steps/common_steps/**/*.rb"))

(support_files + common_steps).each do |f|
  require f
end

Capybara.javascript_driver = :webkit

DatabaseCleaner.strategy = :truncation

Spinach.hooks.around_scenario do |scenario_data, step_definitions, &block|
  DatabaseCleaner.start
  block.call
  DatabaseCleaner.clean
end
