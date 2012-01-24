class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end
  end

  # add all recipes as one user's favorites
  # user = User.find_by_email('<the_email>')
  # recipes = Recipe.all
  # recipes.each do |r|
  #   user.favorites.create(:recipe_id => r)
  # end
end
