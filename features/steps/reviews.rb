class Spinach::Features::Reviews < Spinach::FeatureSteps
  attr_accessor :user, :recipe
  include CommonSteps::Login

  step 'a recipe exists' do
    self.recipe = FactoryGirl.create(:recipe)
  end

  step 'I visit the recipe' do
    visit recipe_path(recipe)
  end

  step 'submit a review' do
    within '#new_review' do
      choose '5'
      fill_in('review_title', :with => 'awesome recipe')
      fill_in('review_body', :with => 'this is the best recipe ever!')

      click_button "Create Review"
    end
  end

  step 'the rating shows up on the recipe index page' do
    visit recipes_path
    within '.recipe' do
      page.should have_css '.rating'
      page.should have_css '.rating .icon-star'
    end
  end

  step 'my review should show up on the recipe page' do
    within '#reviews .well' do
      page.should have_content("awesome recipe")
      page.should have_content("this is the best recipe ever!")
    end
  end
end
