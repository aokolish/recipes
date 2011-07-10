class DeleteIngredients < ActiveRecord::Migration
  def self.up
    drop_table :ingredients
  end

  def self.down
  end
end
