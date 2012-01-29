require 'spec_helper'

describe "creating a user" do
  context "with valid input" do
    it "shows that the account has been created" do
      visit new_user_path
      fill_in "user_email", :with => "awesome@example.com"
      fill_in "user_password", :with => "password"
      fill_in "user_password_confirmation", :with => "password"
      click_button "Create User"

      current_path.should eq(recipes_path)
      page.should have_content("Your account has been created!")
      page.should have_content("Logged in as awesome@example.com")
    end
  end

  context "with invalid input" do
    it "tells the user that there are errors" do
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
end
