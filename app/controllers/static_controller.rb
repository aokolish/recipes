class StaticController < ApplicationController
  skip_before_filter :authorize
  def home
    redirect_to recipes_path if current_user
  end

end
