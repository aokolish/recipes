require 'spec_helper'

describe "login/logout" do
  it "requires you to log in for some pages" do
    visit new_recipe_path
    current_path.should eq(login_path)
    page.should have_content("Please log in or create an account.")
  end

  it "redirects you to the default path when you log in" do
    user = FactoryGirl.create(:user)
    login(user)
    current_path.should eq(recipes_path)
    page.should have_content("Logged in!")
    page.should have_content("Logged in as #{user.email}")
  end

  it "redirects you to the default path when you log in" do
    visit new_recipe_path
    login

    current_path.should eq(new_recipe_path)
  end

  it "allows you to log out" do
    login
    click_link "Log out"

    current_path.should eq(root_path)
    page.should have_content("Logged out!")
  end
end
