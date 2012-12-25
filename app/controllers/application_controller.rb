class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :return_to
  before_filter :authorize
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def return_to
    unless controller_name == "sessions"
      session[:return_to] = request.url
    end
  end

  def authorize
    if current_user.nil?
      redirect_to login_url, :notice => "Please log in or create an account.".html_safe
    end
  end
end
