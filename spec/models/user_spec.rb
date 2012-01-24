require 'spec_helper'

describe User do
  describe "validation" do
    let(:user) { FactoryGirl.build(:user) }

    it "should be invalid without an email" do
      user.email = nil
      user.should_not be_valid
      user.errors[:email].should eq(["can't be blank", "is an invalid format"])
    end

    it "should validate format of the email" do
      user.email = '123'
      user.should_not be_valid
      user.errors[:email].should eq(["is an invalid format"])
      user.email = '1234@example.com'
      user.should be_valid
    end

    it "should be invalid without a password" do
      user.password = nil
      user.should_not be_valid
      user.errors[:password].should eq(["can't be blank", "is too short (minimum is 4 characters)"])
    end

    it "should require password of at least 4 characters" do
      user.password = 'asd'
      user.should_not be_valid
      user.errors[:password].should eq(["is too short (minimum is 4 characters)"])

      user.password = 'asdf'
      user.should be_valid
    end

    it "should require password and password_confirmation to match" do
      user.password = 'asdf'
      user.password_confirmation = 'qewr'
      user.should_not be_valid
      user.errors[:password].should eq(["doesn't match confirmation"])
    end
  end

  describe "#authenticate" do
    let(:user) { Factory(:user) }

    it "should authenticate with matching email and password" do
      User.authenticate(user.email, user.password).should == user
    end

    it "should not authenticate with matching email and password" do
      User.authenticate(user.email, 'notcorrect').should be_nil
    end
  end
end
