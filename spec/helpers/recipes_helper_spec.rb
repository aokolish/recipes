require 'spec_helper'

describe RecipesHelper do
  describe "#timestamp" do
    it "returns a message with a formatted date" do
      Time.stub(now: Time.utc(2013,"mar",1))
      helper.timestamp(Time.utc(2012,"dec",1)).should eq('<i>Added 3 months ago</i>')
    end
  end
end

