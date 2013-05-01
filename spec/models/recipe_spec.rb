require 'spec_helper'

describe Recipe do
  let(:recipe) { Recipe.new(:title => 'Pasta',
                            :ingredients => '1 pound spaghetti|water|salt',
                            :directions => 'boil generous amount of water|add salt|boil pasta') }

  describe "#ingredients" do
    it "splits the ingredients on pipes" do
      subject.ingredients = "this|is|a|test"
      subject.ingredients_array.should eq(["this", "is", "a", "test"])
    end
  end

  describe "#directions_array" do
    it "splits the directions on pipes" do
      subject.directions = "this|is|a|test"
      subject.directions_array.should eq(["this", "is", "a", "test"])
    end
  end

  describe ".search" do
    let(:recipe) { FactoryGirl.build(:recipe, :title => 'Pasta',
                                     :ingredients => '1 pound spaghetti|water|salt',
                                     :directions => 'boil generous amount of water|add salt|boil pasta') }
    it "returns an empty array if nothing is found" do
      Recipe.search('aoeu').should eq([])
    end

    it "returns recipes based on title, ingredients, or directions" do
      recipe.save
      Recipe.search('Pasta').first.should eq(recipe)
      Recipe.search('add salt').first.should eq(recipe)
      Recipe.search('pound spaghetti').first.should eq(recipe)
    end

    it "returns case insensitive matches" do
      recipe.save
      Recipe.search('pasta').first.should eq(recipe)
      Recipe.search('ADD SALT').first.should eq(recipe)
      Recipe.search('POUND SPAGHETTI').first.should eq(recipe)
    end
  end

  describe "#favorite_for?" do
    it "returns true if the recipe is in the user's favorites" do
      fav = FactoryGirl.create(:favorite)
      user = fav.user
      fav.recipe.favorite_for?(user).should eq(true)
    end

    it "returns false if the recipe is not in the user's favorites" do
      recipe.favorite_for?(FactoryGirl.build(:user)).should eq(false)
    end
  end

  describe "#has_rating?" do
    it 'returns true if there are ratings' do
      subject.stub(rating: 3)
      subject.has_rating?.should be_true
    end
    it 'returns false if there are ratings' do
      subject.stub(rating: 0)
      subject.has_rating?.should be_false
    end
  end

  describe "#review_count" do
    it "gets the count of the reviews" do
      reviews = double(:reviews, count: 12)
      subject.stub(:reviews => reviews)
      subject.review_count.should eq 12
    end
  end

  describe "#rating" do
    it "returns the average rating" do
      Review.should_receive(:avg_rating_for).with(subject)
      subject.rating
    end
  end

  describe ".from_import" do
    it "returns a recipe from scraping a site" do
      recipe = double :recipe
      Scraper.stub_chain(:new, scrape: recipe)
      Recipe.from_import('some url').should eq recipe
    end
  end

  describe "#recent_reviews" do
    it "returns reviews" do
      reviews = double(:reviews, count: 12)
      subject.stub(:reviews => reviews)
      reviews.should_receive(:order).with('created_at DESC').and_return(
        double :reviews, limit: true)
      subject.recent_reviews
    end
  end

  describe "#replace_pipes" do
    it "replaces pipes with newlines by default" do
      recipe.replace_pipes
      recipe.directions.should_not match /\|/
      recipe.directions.should match /\n\n/

      recipe.ingredients.should_not match /\|/
      recipe.ingredients.should match /\n\n/
    end

    it "puts the pipes back in after validations" do
      recipe.replace_pipes
      recipe.directions.should_not match /\|/
      recipe.valid?

      recipe.directions.should match /\|/
    end

    it "replaces pipes with a specified separator" do
      recipe.replace_pipes('*')
      recipe.directions.should_not match /\|/
      recipe.directions.should match /\*/

      recipe.ingredients.should_not match /\|/
      recipe.ingredients.should match /\*/
    end

    it "replace pipes on specified attributes" do
      recipe.replace_pipes('*', [:directions])
      recipe.directions.should_not match /\|/
      recipe.directions.should match /\*/

      recipe.ingredients.should match /\|/
      recipe.ingredients.should_not match /\*/
    end
  end

  describe "#added_by_author?" do
    it "returns true when the author is the user who created the recipe" do
      user = stub(username: 'bill')
      recipe.stub(user: user, author: 'bill')
      recipe.added_by_author?.should be_true
    end

    it "returns false if the author is not the user who created the recipe" do
      user = stub(username: 'bill')
      recipe.stub(user: user, author: 'jane')
      recipe.added_by_author?.should be_false
    end

    it "returns false if the recipe's user is nil" do
      user = nil
      recipe.stub(user: nil, author: 'jane')
      recipe.added_by_author?.should be_false
    end
  end
end
