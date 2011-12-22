require 'spec_helper'

describe "SearchRecipes" do
  before(:all) do
    Recipe.destroy_all
    Recipe.create(  :title => "Hamburgers", 
                    :author => "Alex", 
                    :directions => "assemble patties|cook on flat-top|put burger on bun with toppings", 
                    :ingredients => "ground chuck|hamburger buns|ketchup")
  end

  it "finds search results", :broken => true do
    visit root_path
    fill_in "search", :with => "ground chuck"
    click_button "Search"
    page.should have_content("Hamburgers")
    page.should have_content("Alex")
    page.should have_content("cook on flat-top")
  end

  it "notifies you when there are no results", :broken => true do
    visit root_path
    fill_in "search", :with => "asfdasdf"
    click_button "Search"
    page.should have_content("Sorry, you searched for 'asfdasdf' and no results were found.")
    page.should_not have_content("Listing recipes")
  end
end
