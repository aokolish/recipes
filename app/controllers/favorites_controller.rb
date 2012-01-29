class FavoritesController < ApplicationController
  skip_before_filter :authorize, :only => [:index]

  def index
    if current_user
      @recipes = current_user.recipes
    else
      flash.notice = "Please <a href='#{url_for(login_path)}'>log in</a> or <a href='#{url_for(new_user_path)}'>create an account</a> to use this feature.".html_safe
    end
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
