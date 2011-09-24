require 'spec_helper'
include UserMacros

describe User do
  describe "#send_password_reset" do
    # let(:user) { Factory(:user) }

    it "generates a unique password_reset_token each time" do
      puts valid_user_attributes
      # user.send_password_reset
      # last_token = user.password_reset_token
      # user.send_password_reset
      # user.password_reset_token.should_not eq(last_token)
    end

    it "saves the time the password reset was sent" do
      # user.send_password_reset
      # user.reload.password_reset_sent_at.should be_present
    end

    it "delivers email to user" do
      # user.send_password_reset
      # last_email.to.should include(user.email)
    end
  end
end


# context "A user (in general)" do
#   include UserSpecHelper
# 
#   setup do
#     @user = User.new
#   end
# 
#   specify "should be invalid without a username" do
#     @user.attributes = valid_user_attributes.except(:username)
#     @user.should_not_be_valid
#     @user.errors.on(:username).should_equal "is required"
#     @user.username = 'someusername'
#     @user.should_be_valid
#   end
# 
#   specify "should be invalid without an email" do
#     @user.attributes = valid_user_attributes.except(:email)
#     @user.should_not_be_valid
#     @user.errors.on(:email).should_equal "is required"
#     @user.email = 'joe@bloggs.com'
#     @user.should_be_valid
#   end
# 
#   specify "should be invalid without a password" do
#     @user.attributes = valid_user_attributes.except(:password)
#     @user.should_not_be_valid
#     @user.password = 'abcdefg'
#     @user.should_be_valid
#   end
#   
#   specify "should be invalid if password is not between 6 and 12 characters in length" do
#     @user.attributes = valid_user_attributes.except(:password)
#     @user.password = 'abcdefghijklm'
#     @user.should_not_be_valid
#     @user.password = 'abcde'
#     @user.should_not_be_valid
#     @user.password = 'abcdefg'
#     @user.should_be_valid
#   end
# end