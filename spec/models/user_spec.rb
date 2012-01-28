require 'spec_helper'

describe User do
  let(:user) { Factory(:user) }

  describe "validation" do
    it "requires an email" do
      user.email = nil
      user.should_not be_valid
      user.errors[:email].should eq(["can't be blank", "is an invalid format"])
    end

    it "validates the format of the email" do
      user.email = '123'
      user.should_not be_valid
      user.errors[:email].should eq(["is an invalid format"])
      user.email = '1234@example.com'
      user.should be_valid
    end

    it "requires a password" do
      user.password = nil
      user.should_not be_valid
      user.errors[:password].should eq(["can't be blank", "is too short (minimum is 4 characters)"])
    end

    it "requires a password of at least 4 characters" do
      user.password = 'asd'
      user.should_not be_valid
      user.errors[:password].should eq(["is too short (minimum is 4 characters)"])

      user.password = 'asdf'
      user.should be_valid
    end

    it "requires password and password_confirmation to match" do
      user.password = 'asdf'
      user.password_confirmation = 'qewr'
      user.should_not be_valid
      user.errors[:password].should eq(["doesn't match confirmation"])
    end
  end

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
      recipe = Factory.create(:recipe, :user_id => user.id)
      user.author?(recipe).should eq(true)
    end

    it "returns false if the user is not the author" do
      recipe = Factory.create(:recipe)
      user.author?(recipe).should eq(false)
    end
  end

  describe "#authored_recipes" do
    it "returns recipes that the user has authored" do
      recipe = Factory.create(:recipe, :user_id => user.id)
      user.authored_recipes.first.class.should eq(Recipe)
      user.authored_recipes.first.user_id.should eq(user.id)
    end
  end
end
