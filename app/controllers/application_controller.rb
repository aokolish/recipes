class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    if current_user.nil?
      redirect_to login_url, :notice => "Please log in or <a href='#{url_for(new_user_path)}'>create an account</a>.".html_safe
    end
  end
end
