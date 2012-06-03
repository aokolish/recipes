require 'spec_helper'

describe "Recipes" do
  let(:recipe) { Factory.build(:recipe) }

  describe "GET /recipes" do
    it "displays recipes" do
      FactoryGirl.create(:recipe, :title => "beer cheese soup")
      visit recipes_path
      page.should have_content("beer cheese soup")
    end

    it "supports js", :js => true do
      visit recipes_path
    end
  end

  describe "POST /recipe" do
    it "creates a recipe" do
      login

      visit new_recipe_path
      fill_in "Title", :with => "chicken soup"
      fill_in "Ingredients", :with => "1 chicken\n2 carrots\n1 onion"
      fill_in "Directions", :with => "do some stuff..."
      fill_in "Author", :with => "budding chef"

      click_button "Submit"
      page.should have_content("Recipe was successfully created.")
      page.should have_content("chicken soup")
    end
  end
end

