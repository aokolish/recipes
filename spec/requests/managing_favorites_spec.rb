require 'spec_helper'

describe "Favorites" do
  let(:user) { FactoryGirl.build(:user) }
  let(:recipe) { FactoryGirl.build(:recipe) }

  before(:all) do
    user.password = 'aoeu'
    user.save
  end

  before(:each) do 
    visit login_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"
  end

  describe "adding a favorite" do
    it "is done via a button on the recipe details page" do
      visit recipe_path(recipe)
      click_button "favorite_recipe"

      page.should have_content("Recipe was successfully added to your favorites!")
      page.find('#flash_notice').should have_link('favorites!', :href => user_favorites_path(user))
    end

    it "the button is disabled if you have already favorited a recipe" do
      click_on "favorite_recipe"
      page.should have_content("That recipe is already in your favorites")
    end

    it "cannot be done when you are logged out" do
      visit recipe_path(recipe)
      page.should_not have_button('favorite_recipe')
    end
  end

  describe "removing a favorite" do
    it "can be done on the favorites page" do
      visit user_favorites_path(user)
      click_button 'Remove'

      page.should have_content('Recipe has been removed from your favorites')
      page.find('#flash_notice').should have_link('Recipe', :href => recipe_path(recipe))
      # this is kinda like an easy undo. if they accidentally remove something,
      # they can use this link to get back to the recipe and favorite it again
    end
  end
end

