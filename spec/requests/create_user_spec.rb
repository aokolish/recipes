require 'spec_helper'

describe "creating a user" do  
  it "should be successful with valid input" do
    visit new_user_path
    fill_in "user_email", :with => "awesome@example.com"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_button "Create User"

    current_path.should eq(root_path)
    page.should have_content("Signed Up!")
    page.should have_content("Logged in as awesome@example.com")
  end

  it "should show errors when needed" do
    visit new_user_path
    fill_in "user_email", :with => "1234"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "notmatching"
    click_button "Create User"

    current_path.should eq(users_path)
    page.should have_content("Password doesn't match confirmation")
    page.should have_content("Email is an invalid format")
  end
end
