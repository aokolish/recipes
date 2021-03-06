class Spinach::Features::CreatingARecipe < Spinach::FeatureSteps
  attr_accessor :user
  include CommonSteps::Login

  step 'I submit a valid recipe' do
    visit new_recipe_path
    fill_in "Title", :with => "chicken soup"
    fill_in "Ingredients", :with => "1 chicken\n2 carrots\n1 onion"
    fill_in "Directions", :with => "do some stuff..."
    fill_in "Author", :with => "budding chef"

    click_button "Submit"
  end

  step 'I should be on the new recipe page' do
    page.should have_content("chicken soup")
  end

  step 'it should say that the recipe was created' do
    page.should have_content("Recipe was successfully created.")
  end
end
