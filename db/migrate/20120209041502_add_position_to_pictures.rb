class AddPositionToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :position, :integer
  end
end
