require 'spec_helper'

describe "SearchRecipes" do
  it "finds search results" do
    FactoryGirl.create(:recipe, :title => 'Hamburgers', :author => 'Alex')
    visit root_path
    fill_in "search", :with => "Hamburgers"
    click_button "search_submit"
    page.should have_content("Hamburgers")
    page.should have_content("Alex")
  end

  it "notifies you when there are no results" do
    visit root_path
    fill_in "search", :with => "asfdasdf"
    click_button "search_submit"
    page.should have_content("Sorry, you searched for 'asfdasdf' and no results were found.")
    page.should_not have_content("Listing recipes")
  end
end
