require 'spec_helper'

describe ReviewHelper do
  describe "#rating_stars" do
    it "returns html for some rating stars" do
      helper.rating_stars(5.0).should eq(
        "<span><i class=\"icon-star\"></i></span><span><i class=\"icon-star\"></i></span><span><i class=\"icon-star\"></i></span><span><i class=\"icon-star\"></i></span><span><i class=\"icon-star\"></i></span>")
      helper.rating_stars(3.0).should eq(
        "<span><i class=\"icon-star\"></i></span><span><i class=\"icon-star\"></i></span><span><i class=\"icon-star\"></i></span>")
      helper.rating_stars(2.5).should eq(
        "<span><i class=\"icon-star\"></i></span><span><i class=\"icon-star\"></i></span><span><i class=\"icon-star-half\"></i></span>")
    end

    it "returns an empty string if the rating is less than zero" do
      helper.rating_stars(0).should eq("")
    end
  end
end

