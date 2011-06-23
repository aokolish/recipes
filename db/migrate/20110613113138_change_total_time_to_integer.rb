class ChangeTotalTimeToInteger < ActiveRecord::Migration
  def self.up
    # if this fails, update all recipes to ensure that they have a value
    # can be converted to an integer like this:
    # 
    # Recipe.all.each do |recipe|
    #   recipe.total_time = 1800
    #   recipe.save
    # end
    
    # default is 30 minutes (1800 seconds)
    change_column :recipes, :total_time, :integer, :default => 1800
  end

  def self.down
    change_column :recipes, :total_time, :string
  end
end
