class ApplicationController < ActionController::Base
  protect_from_forgery  
  before_filter :prepare_for_mobile
  before_filter :authorize
  helper_method :current_user

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authorize
    if current_user.nil?
      redirect_to login_url, :notice => "Please log in"
    end
  end
end
