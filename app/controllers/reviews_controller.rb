class ReviewsController < ApplicationController
  skip_before_filter :authorize, :only => [:index]
  respond_to :json, :html, :js
  expose(:review)
  expose(:recipe) { Recipe.find(params[:recipe_id]) }

  def create
    review.save
    respond_with review
  end

  def update
    if review.save
      flash.notice = "review updated!"
    end
    respond_with review, location: review.recipe
  end
end
