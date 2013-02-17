require 'spec_helper'

describe Review do
  describe ".avg_rating_for" do
    context "with some all 5's" do
      let(:recipe) { double(:recipe, id: 1) }

      it "averages the ratings for a recipe" do
        Review.stub_chain(:where, :pluck => [5, 5, 5])
        Review.avg_rating_for(recipe).should eq(5)

        Review.stub_chain(:where, :pluck => [5, 2])
        Review.avg_rating_for(recipe).should eq(3.5)

        Review.stub_chain(:where, :pluck => [1, 1, 1])
        Review.avg_rating_for(recipe).should eq(1)
      end
    end
  end
end
