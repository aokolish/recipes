class ChangeTotalTimeToInteger < ActiveRecord::Migration
  def self.up
    # if this fails, update all recipes to ensure that they have a value
    # can be converted to an integer like this:
    # 
    # Recipe.all.each do |recipe|
    #   recipe.total_time = 1800
    #   recipe.save
    # end
    
    change_column :recipes, :total_time, :integer
  end

  def self.down
    change_column :recipes, :total_time, :string, :default => nil
  end
end
