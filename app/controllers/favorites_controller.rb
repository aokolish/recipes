class FavoritesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def create
    @favorite = Favorite.new(params[:favorite])

    if @favorite.save
      redirect_to(user_favorites_path(current_user), :notice => 'Favorite was added')
    else
      redirect_to('/', :notice => 'Sorry, the recipe could not be added to your favorites')
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to user_favorites_path(current_user), :notice => 'Recipe has been removed from your favorites'
  end

end
