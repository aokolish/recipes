require 'spec_helper'

describe "ImportRecipes" do
  before(:each) do
    login
  end

  it "imports a recipe via scraping" do
    visit import_recipes_path
    fill_in "source_url", :with => "http://www.foodnetwork.com/example"
    click_button "Submit"
    page.should have_content("Recipe was successfully created")

    visit recipes_path
    page.should have_content("Strawberries-and-Cream Tart")
  end

  it "tells you when the recipe has already been imported" do
    visit import_recipes_path
    fill_in "source_url", :with => "http://www.foodnetwork.com/example"
    click_on "Submit"
    page.should have_content("Recipe was successfully created")

    visit import_recipes_path
    fill_in "source_url", :with => "http://www.foodnetwork.com/example"
    click_on "Submit"
    page.should have_content("Sorry, that recipe has already been imported")
  end

  it "cannot scrape all sites" do
    visit import_recipes_path
    fill_in "source_url", :with => "google.com"
    click_button "Submit"
    page.should have_content("Sorry, there was a problem creating a recipe from")
  end
end
