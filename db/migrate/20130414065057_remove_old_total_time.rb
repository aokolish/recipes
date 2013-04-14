class RemoveOldTotalTime < ActiveRecord::Migration
  def up
    remove_column :recipes, :old_total_time
  end
end
