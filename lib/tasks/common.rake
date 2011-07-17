task :delete_last => :environment do |t, args|
  # sample call: rake delete_last n=2
  desc "deletes the last <n> recipes"
  n = ENV['n'].to_i
  last = Recipe.last(n)
  last.each do |recipe|
    recipe.destroy
  end
  puts "deleted #{n} recipes"
end