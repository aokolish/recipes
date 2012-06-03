module UserMacros
  # user is optional - pass it in if you need to work with the
  # user elsewhere in the spec
  def login(user=FactoryGirl.create(:user))
    visit login_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"
  end
end
