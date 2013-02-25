require 'simplecov'
SimpleCov.configure do
  SimpleCov.refuse_coverage_drop
  add_filter "/spec/"
  add_filter "scraper.rb" # don't care that this is spaghetti code
  add_filter "error_messages_helper.rb"
  add_filter "/config/"
  add_filter "/features/"
  add_filter "controller"
  SimpleCov.minimum_coverage 99
end
