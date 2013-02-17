class Spinach::Features::Reviews < Spinach::FeatureSteps
  attr_accessor :user, :recipe

  step 'I am logged in' do
    self.user = FactoryGirl.create(:user)

    visit login_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"
  end

  step 'a recipe exists' do
    self.recipe = FactoryGirl.create(:recipe)
  end

  step 'I visit the recipe' do
    pending 'step not implemented'
  end

  step 'submit a review' do
    pending 'step not implemented'
  end

  step 'my review should show up on the recipe page' do
    pending 'step not implemented'
  end

  step 'I have reviewed recipes before' do
    pending 'step not implemented'
  end

  step 'I go to my user page' do
    pending 'step not implemented'
  end

  step 'I see the reviews listed there' do
    pending 'step not implemented'
  end
end
