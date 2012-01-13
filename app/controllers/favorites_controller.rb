class FavoritesController < ApplicationController
  def index
    #@favorites = current_user.favorites
    @recipes = current_user.recipes
    # if I order both of these by :recipe_id they would be in sync
    # as I iterate over them, right?
  end

  def create
    @favorite = Favorite.new(params[:favorite])

    if @favorite.save
      redirect_to(user_favorites_path(current_user), :notice => 'Favorite was added')
    else
      redirect_to('/', :notice => 'there was a problem')
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to user_favorites_path(current_user), :notice => 'Recipe was deleted'
  end

end
