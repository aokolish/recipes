class AddPictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :caption
      t.references :imageable, :polymorphic => true   # creates imageable_id and imageable_type
      t.timestamps
    end
  end
end
