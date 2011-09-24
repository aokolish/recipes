require 'spec_helper'

describe "login/logout" do
  let(:user) { Factory(:user) }
  
  it "requires you to log in for some pages" do
    visit new_recipe_path
    current_path.should eq(login_path)
  end
  
  it "redirects you when you log in" do
    visit root_path
    click_link "log in"
    
    current_path.should eq(login_path)
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"
    
    current_path.should eq(root_path)
    page.should have_content("Logged in!")
    page.should have_content("Logged in as #{user.email}")
  end
  
  it "allows you to log out" do
    # visit new_user_path
    # fill_in "user_email", :with => "1234"
    # fill_in "user_password", :with => "password"
    # fill_in "user_password_confirmation", :with => "notmatching"
    # click_button "Create User"
    # 
    # current_path.should eq(users_path)
    # page.should have_content("Password doesn't match confirmation")
    # page.should have_content("Email is an invalid format")
  end
end