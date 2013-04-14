class Spinach::Features::CreateAccount < Spinach::FeatureSteps
  step 'I fill in the form with valid input' do
    fill_in "user_email", :with => "awesome@example.com"
    fill_in "user_username", :with => "awesome"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_button "Create User"
  end

  step 'I should be on the recipes page' do
    current_path.should eq(recipes_path)
  end

  step 'I should see that my account has been created' do
    page.should have_content("Your account has been created!")
  end

  step 'I should be logged in' do
    page.find('.avatar-link').should have_content("awesome@example.com")
  end

  step 'I fill in the form with invalid input' do
    fill_in "user_email", :with => "1234"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "notmatching"
    click_button "Create User"
  end

  step 'I should be on the same page' do
    current_path.should eq(users_path)
  end

  step 'I should see a message for each error' do
    page.should have_content("doesn't match confirmation")
    page.should have_content("is an invalid format")
  end

  step 'I am on the new user page' do
    visit new_user_path
  end
end
