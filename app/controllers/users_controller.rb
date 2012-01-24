class UsersController < ApplicationController
  skip_before_filter :authorize
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to recipes_url, :notice => "Your account has been created!"
    else
      render "new"
    end
  end

end
