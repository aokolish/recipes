class UsersController < ApplicationController
  skip_before_filter :authorize
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Signed Up!"
    else
      render "new"
    end
  end

end
