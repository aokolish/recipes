require 'spec_helper'

describe "ImportRecipes" do
  describe "desktop version" do
    it "imports a recipe via scraping" do
      visit import_recipes_path
      fill_in "source_url", :with => "http://www.foodnetwork.com/recipes/strawberries-and-cream-tart-recipe/index.html"
      click_button "Submit"
      page.should have_content("Recipe was successfully created")
    end
    
    it "will not import the same recipe twice" do
      visit import_recipes_path
      fill_in "source_url", :with => "http://www.foodnetwork.com/recipes/rachael-ray/my-moms-tomato-and-bean-15-minute-stoup-recipe/index.html"
      click_button "Submit"
      page.should have_content("Recipe was successfully created")
      
      visit import_recipes_path
      fill_in "source_url", :with => "http://www.foodnetwork.com/recipes/rachael-ray/my-moms-tomato-and-bean-15-minute-stoup-recipe/index.html"
      click_button "Submit"
      page.should have_content("Sorry, that recipe has already been imported")
    end
  
    it "cannot scrape all sites" do
      visit import_recipes_path
      fill_in "source_url", :with => "google.com"
      click_button "Submit"
      page.should have_content("Sorry, there was a problem creating a recipe from")
    end
  end
  
  describe "mobile version" do
    it "imports a recipe via scraping" do
      visit import_recipes_path(:mobile => '1')
      fill_in "source_url", :with => "http://www.foodnetwork.com/recipes/strawberries-and-cream-tart-recipe/index.html"
      click_button "Submit"
      page.should have_content("Recipe was successfully created")
    end
    
    it "will not import the same recipe twice" do
      visit import_recipes_path
      fill_in "source_url", :with => "http://www.foodnetwork.com/recipes/rachael-ray/my-moms-tomato-and-bean-15-minute-stoup-recipe/index.html"
      click_button "Submit"
      page.should have_content("Recipe was successfully created")
      
      visit import_recipes_path
      fill_in "source_url", :with => "http://www.foodnetwork.com/recipes/rachael-ray/my-moms-tomato-and-bean-15-minute-stoup-recipe/index.html"
      click_button "Submit"
      page.should have_content("Sorry, that recipe has already been imported")
    end
  
    it "cannot scrape all sites" do
      visit import_recipes_path
      fill_in "source_url", :with => "google.com"
      click_button "Submit"
      page.should have_content("Sorry, there was a problem creating a recipe from")
    end
  end
end
