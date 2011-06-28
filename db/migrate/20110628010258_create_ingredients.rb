class CreateIngredients < ActiveRecord::Migration
  def self.up
    create_table :ingredients do |t|
      t.string :quantity
      t.string :unit_of_measure
      t.string :name
      t.string :preparation

      t.timestamps
    end
  end

  def self.down
    drop_table :ingredients
  end
end
