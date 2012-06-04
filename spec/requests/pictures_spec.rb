require 'spec_helper'

describe "Pictures" do
  describe "POST /recipes/:id/pictures" do
    it "creates pictures" do
      login
      recipe = FactoryGirl.create(:recipe)

      visit recipe_pictures_path(recipe)

      can_attach_photo('peppers-at-market.jpg', 'a picture caption')
      can_attach_photo('Peppers2 1955.jpg', 'another picture caption')
    end
  end

  def can_attach_photo(photo, caption=nil)
    attach_file 'picture[image]', "#{Rails.root}/spec/images/#{photo}"
    caption && (fill_in 'picture[caption]', :with => caption)
    click_button "Submit"

    page.should have_content("Image added!")
    caption && (page.should have_content(caption))
  end
end

  # For possible turnip tests in the future:
  # Given I am logged in
  # When I go to the pictures page
  # And I add a picture with a caption
  # Then I should see the picture and the caption

  # Give I am logged in
  # When I edit a repipe with two photos
  # And I drag the thumbnails
  # Then I can sort the photos

  # things to test:
  # adding a photo
  # adding a second one
  # viewing picture captions
  # changing the order by dragging pictures

