class MigrationDurationData < ActiveRecord::Migration
  def up
    rename_column :recipes, :total_time, :old_total_time
    add_column :recipes, :total_time, :string

    Recipe.all.each do |recipe|
      old_time = recipe.old_total_time
      recipe.total_time = if old_time
                            ChronicDuration.output(recipe.old_total_time)
                          else
                            ''
                          end
      recipe.save
    end
  end
end
