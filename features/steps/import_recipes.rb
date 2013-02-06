class Spinach::Features::ImportRecipes < Spinach::FeatureSteps
  attr_accessor :user

  def import_recipe(url)
    if page.current_path != import_recipes_path
      visit import_recipes_path
    end

    fill_in "source_url", :with => url
    click_button "Submit"
  end

  step 'I submit the import form' do
    import_recipe "http://www.foodnetwork.com/example"
  end

  step 'a recipe should be created' do
    page.should have_content("Recipe was successfully created")
  end

  step 'I import the same recipe twice' do
    import_recipe "http://www.foodnetwork.com/example"
    import_recipe "http://www.foodnetwork.com/example"
  end

  step 'I should see a message saying the recipe has already been imported' do
    page.should have_content("Sorry, that recipe has already been imported")
  end

  step 'I try to import from an unsupported site' do
    import_recipe "http://www.google.com"
  end

  step 'I should see a message saying that cannot be done' do
    page.should have_content("Sorry, there was a problem creating a recipe from")
  end

  step 'I am on the import page' do
    visit import_recipes_path
  end

  step 'I am logged in' do
    self.user = FactoryGirl.create(:user)

    visit login_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"
  end
end
