class SearchingRecipes < Spinach::FeatureSteps
  attr_accessor :recipe

  Given 'a recipe exists' do
    self.recipe = FactoryGirl.create(:recipe)
  end

  When 'I search for it by title' do
    # NOTE: not sure I agree with this approach
    # this is not what a user actually does...
    visit search_recipes_path(:search => recipe.title)
  end

  Then 'it should come up in the results' do
    page.should have_content(recipe.title)
  end

  Given 'three recipes come up in my search results' do
    3.times do |n|
      FactoryGirl.create(:recipe,
                         :created_at => n.days.ago,
                         :title => "recipe no #{n}",
                         :ingredients => 'cheese')
    end
    visit search_recipes_path(:search => 'cheese')
  end

  When 'I click the \'Date Created\' sort button' do
    click_link('Date Created')
  end

  When 'I click the \'Best Match\' sort button' do
    click_link('Best Match')
  end

  Then 'the search results should be ordered by date created descending' do
    page.find('#results li:first-child').should have_content('recipe no 0')
  end

  Then 'the search results should be ordered by date created ascending' do
    page.find('#results li:first-child').should have_content('recipe no 2')
  end

  And 'when I click it again' do
    click_link('Date Created')
  end

  Then 'I should see the original search results' do
    page.find('#results li:first-child').should have_content('recipe no 0')
    page.find('#results li:last-child').should have_content('recipe no 2')
  end

  When 'I search and get no results' do
    visit search_recipes_path(:search => 'aoeuaoeu')
  end

  Then 'there should be a message telling me nothing was found' do
    page.should have_content(
      "Sorry, you searched for 'aoeuaoeu' and no results were found.")
  end
end
