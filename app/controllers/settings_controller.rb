class SettingsController < ApplicationController
  def update
    if current_user.update_attributes params[:user]
      flash.notice = 'Your profile has been updated!'
    end
    render "profile"
  end

  def profile
  end
end
