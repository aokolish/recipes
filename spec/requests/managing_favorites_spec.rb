require 'spec_helper'

describe "Favorites" do
  let(:user) { FactoryGirl.create(:user) }
  let(:recipe) { FactoryGirl.create(:recipe) }

  describe "adding a favorite" do
    context "when logged in" do
      it "creates a new favorite" do
        login(user)
        visit recipe_path(recipe)
        click_button "favorite_recipe"

        page.should have_content("Favorite was added")
      end
    end

    context "when logged out" do
      it "hides the favorite button" do
        visit recipe_path(recipe)
        page.should_not have_button('favorite_recipe')
      end
    end
  end

  describe "removing a favorite" do
    context "from the favorites page" do
      it "shows a message that it has been removed" do
        login(user)
        visit recipe_path(recipe)
        click_button "favorite_recipe"

        click_link 'Remove this from your favorites'
        page.should have_content('Recipe has been removed from your favorites')
        #page.find('#flash_notice').should have_link('Recipe', :href => recipe_path(recipe))
        # this is kinda like an easy undo. if they accidentally remove something,
        # they can use this link to get back to the recipe and favorite it again
      end
    end

    context "from the recipe page" do
      it "shows a message that it has been removed", :js => true do
        login(user)
        visit recipe_path(recipe)
        click_button "favorite_recipe"

        visit recipe_path(recipe)
        remove_link = page.find('.actions .remove_favorite')
        remove_link.trigger(:mouseover)
        page.should have_content("Remove this from your favorites")

        remove_link.click
        page.should have_content('Recipe has been removed from your favorites')
      end
    end
  end

  def login(user)
    visit login_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"
  end
end

