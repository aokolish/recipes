require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'rspec/core/rake_task'

Recipes::Application.load_tasks

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--format documentation]
end

desc 'Run spinach features'
task :spinach do
  exec "bundle exec spinach"
end

task :default => [:spec, :spinach]
