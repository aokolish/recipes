class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.authenticate(params[:email].downcase, params[:password])
    if user
      session[:user_id] = user.id
      redirect_to destination, :notice => "Logged in!"
      session[:return_to] = nil
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

  def destination
    session[:return_to] || :root
  end

end
