Rake::Task['assets:precompile'].clear
namespace :assets do
  task :precompile do
    puts '* rake assets:precompile has been disabled (lib/tasks/disable_precompile.rake)'
  end
end
