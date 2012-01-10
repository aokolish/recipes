#describe RecipeBox do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

require 'spec_helper'

describe Favorite do
  let(:user) { FactoryGirl.build(:user) }

  # there is probably a better way to get a user logged in
  before(:all) do
    user.password = 'aoeu'
    user.save
  end

  before(:each) do 
    visit login_path
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Log in"
  end

  pending "add some examples to (or delete) #{__FILE__}"
  # favorite rules should be handled in the user/recipe classes?
  #
  # e.g. -

    #<manual> POST request to favorite (unit test?)
    #should redirect to recipe page with a flash message?

    # what happens if you try to to remove something not in the list? (unit test)
end


