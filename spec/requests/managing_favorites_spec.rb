require 'spec_helper'

describe "Favorites" do
  let(:user) { FactoryGirl.create(:user) }
  let(:recipe) { FactoryGirl.create(:recipe) }

  describe "adding a favorite" do
    it "is done via a button on the recipe details page" do
      login
      visit recipe_path(recipe)
      click_button "favorite_recipe"

      page.should have_content("Favorite was added")
    end

    it "the button is disabled if you have already favorited a recipe" do
      login
      visit recipe_path(recipe)
      click_button "favorite_recipe"
      visit recipe_path(recipe)

      favorite_button = page.find('.actions .disabled_favorite')
      favorite_button.trigger(:hover)
      page.should have_content("This recipe is already in your favorites")
    end

    it "cannot be done when you are logged out" do
      visit recipe_path(recipe)
      page.should_not have_button('favorite_recipe')
    end
  end

  describe "removing a favorite" do
    it "can be done on the favorites page" do
      login
      visit recipe_path(recipe)
      click_button "favorite_recipe"

      click_link 'Remove this favorite'

      page.should have_content('Recipe has been removed from your favorites')
      #page.find('#flash_notice').should have_link('Recipe', :href => recipe_path(recipe))
      # this is kinda like an easy undo. if they accidentally remove something,
      # they can use this link to get back to the recipe and favorite it again
    end
  end

  def login
    visit login_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"
  end
end

