class Spinach::Features::Favorites < Spinach::FeatureSteps
  attr_accessor :user, :recipe
  include CommonSteps::Login

  before do
    self.recipe = FactoryGirl.create(:recipe)
  end

  step 'I favorite a recipe on the recipe page' do
    visit recipe_path(recipe)
    click_button "favorite-recipe"
  end

  step 'it should say that the favorite was added' do
    page.should have_content("Favorite was added")
  end

  step 'I visit a recipe page' do
    visit recipe_path(recipe)
  end

  step 'there is no favorite link' do
    page.should_not have_button('favorite-recipe')
  end

  step 'I have an existing favorite' do
    self.user = FactoryGirl.create(:user)

    visit login_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"

    # how do I call an existing step???
    visit recipe_path(recipe)
    click_button "favorite-recipe"
  end

  step 'I click the remove favorite link' do
    find('.remove_favorite').click
  end

  step 'it should say that the favorite was removed' do
    page.should have_content('Recipe has been removed from your favorites')
  end
end
