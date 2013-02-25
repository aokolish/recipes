class Review < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  validates :rating, :title, :body, :user_id, :recipe_id, presence: true
  validates :recipe_id, uniqueness: { scope: :user_id }

  class << self
    def avg_rating_for(recipe)
      ratings = where(recipe_id: recipe.id).pluck(:rating)
      ratings.reduce(:+).to_f / ratings.size
    end
  end
end
