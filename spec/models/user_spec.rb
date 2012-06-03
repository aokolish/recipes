require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe ".authenticate" do
    it "returns a user with matching email and password" do
      User.authenticate(user.email, user.password).should == user
    end

    it "returns nil with the incorrect email/password combination" do
      User.authenticate(user.email, 'notcorrect').should be_nil
    end
  end

  describe "#author?" do
    it "returns true if the user is the author" do
      recipe = FactoryGirl.create(:recipe, :user_id => user.id)
      user.author?(recipe).should eq(true)
    end

    it "returns false if the user is not the author" do
      recipe = FactoryGirl.create(:recipe)
      user.author?(recipe).should eq(false)
    end
  end

  describe "#authored_recipes" do
    it "returns recipes that the user has authored" do
      recipe = FactoryGirl.create(:recipe, :user_id => user.id)
      user.authored_recipes.first.class.should eq(Recipe)
      user.authored_recipes.first.user_id.should eq(user.id)
    end
  end
end
