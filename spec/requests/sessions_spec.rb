require 'spec_helper'

describe "login/logout" do
  it "requires you to log in for some pages" do
    visit new_recipe_path
    current_path.should eq(login_path)
    page.should have_content("Please log in or create an account.")
  end

  context "the last page did not require authentication" do
    it "redirects you to the default path when you log in" do
      recipe = FactoryGirl.create(:recipe)
      visit recipe_path(recipe)
      login
      current_path.should eq(recipe_path(recipe))
      page.should have_content("Logged in!")
    end
  end

  context "the last page did require authentication" do
    it "redirects you to the default path when you log in" do
      visit new_recipe_path
      login

      current_path.should eq(new_recipe_path)
    end
  end

  it "allows you to log out" do
    login
    click_link "Log out"

    current_path.should eq(root_path)
    page.should have_content("Logged out!")
  end
end
