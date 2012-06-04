step "I am logged in" do
  user = FactoryGirl.create(:user)
  visit login_path
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => user.password
  click_button 'Log in'
end

step "I go to the pictures page" do
  @recipe = FactoryGirl.create(:recipe)
  visit recipe_pictures_path(@recipe)
end

step "add two pictures with captions" do
  attach_file 'picture[image]', "#{Rails.root}/spec/images/peppers-at-market.jpg"
  fill_in 'picture[caption]', :with => 'some caption'
  click_button "Submit"

  attach_file 'picture[image]', "#{Rails.root}/spec/images/Peppers2 1955.jpg"
  fill_in 'picture[caption]', :with => 'another caption'
  click_button "Submit"
end

step "I should see the pictures and the captions" do
  page.should have_css('img[alt="Large_peppers-at-market"]')
  page.should have_css('img[alt="Large_peppers2_1955"]')

  page.should have_content('some caption')
  page.should have_content('another caption')
end

step "I should see them on the recipe and the recipes page" do
  visit recipe_path(@recipe)
end

#def attach_photo(photo, caption=nil)
#  attach_file 'picture[image]', "#{Rails.root}/spec/images/#{photo}"
#  caption && (fill_in 'picture[caption]', :with => caption)
#  click_button "Submit"
#end
