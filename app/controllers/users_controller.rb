class UsersController < ApplicationController
  skip_before_filter :authorize
  expose(:user)

  def new
  end

  def create
    user.email = user.email.downcase
    if user.save
      session[:user_id] = user.id
      redirect_to recipes_url, :notice => "Your account has been created!"
    else
      render "new"
    end
  end

end
