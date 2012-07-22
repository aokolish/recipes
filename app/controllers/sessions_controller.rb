class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.authenticate(params[:email].downcase, params[:password])
    if user
      session[:user_id] = user.id
      redirect_back_or_to recipes_url, :notice => "Logged in!"
      session[:return_to_url] = nil
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

private

  def redirect_back_or_to(url, flash_hash = {})
    redirect_to(session[:return_to_url] || url, :flash => flash_hash)
  end

end
