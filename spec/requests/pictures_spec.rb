require 'spec_helper'
include ActionDispatch::TestProcess

describe "Pictures" do
  # let(:recipe) { Factory.build(:recipe) }

  describe "GET /recipes/:id/pictures" do
    it "displays pictures" do
      #visit recipe_pictures_path(recipe)
      #page.should have_content("beer cheese soup")
    end
  end

  describe "POST /recipes/:id/pictures" do
    # Given I am logged in
    # When I go to the pictures page
    # And I add a picture with a caption
    # Then I should see the picture and the caption
    it "creates pictures" do
      login
      recipe = FactoryGirl.create(:recipe)

      visit recipe_pictures_path(recipe)

      attach_photo('peppers-at-market.jpg', 'a picture caption')
      attach_photo('Peppers2 1955.jpg', 'another picture caption')
    end
  end

  describe "sorting photos" do
    # Give I am logged in
    # When I edit a repipe with two photos
    # And I drag the thumbnails
    # Then I can sort the photos
    it "photos can be sorted" do
      login
      recipe = FactoryGirl.create(:recipe_with_pictures)
      visit recipe_pictures_path(recipe)
    end
  end

  def attach_photo(photo, caption=nil)
    attach_file 'picture[image]', "#{Rails.root}/spec/images/#{photo}"
    caption && (fill_in 'picture[caption]', :with => caption)
    click_button "Submit"

    page.should have_content("Image added!")
    caption && (page.should have_content(caption))
  end

  # things to test:
  # adding a photo DONE
  # viewing picture captions DONE
  # adding a second one DONE
  # changing the order by dragging pictures?
end

