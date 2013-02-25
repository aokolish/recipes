require 'spec_helper'

describe ApplicationHelper do
  describe "#twitterized_type" do
    it "returns classes for bootstrap based on flash types" do
      helper.twitterized_type(:alert).should eq('warning')
      helper.twitterized_type(:error).should eq('error')
      helper.twitterized_type(:notice).should eq('info')
      helper.twitterized_type(:success).should eq('success')
      helper.twitterized_type(:notthere).should eq('notthere')
    end
  end

  describe "#sortable" do
    # this test seems crappy
    it "returns a best match link" do
      helper.stub(params: {search:"aoeu"})
      helper.sortable('best_match').should eq(
        "<a href=\"/recipes/search?search=aoeu\" class=\"btn btn-large active\">Best Match</a>")
    end

    it "returns a link that maps to a column" do
      helper.stub(params: {search:"aoeu"})
      helper.stub(sort_direction: 'asc')
      helper.stub(sort_column: true)
      helper.sortable('created_at').should eq(
        "<a href=\"/recipes/search?direction=desc&amp;search=aoeu&amp;sort=created_at\" class=\"btn btn-large \">Created At</a>")
    end
  end
end

