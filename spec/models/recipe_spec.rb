require 'spec_helper'

describe Recipe do
  let(:recipe) { Factory.build(:recipe, :title => 'Pasta',
                               :ingredients => '1 pound spaghetti|water|salt',
                               :directions => 'boil generous amount of water|add salt|boil pasta') }
  describe "validations" do
    it "requires a title" do
      recipe.title = nil
      recipe.should_not be_valid
      recipe.errors[:title].should eq(["can't be blank"])
    end

    it "requires an author" do
      recipe.author = nil
      recipe.should_not be_valid
      recipe.errors[:author].should eq(["can't be blank"])
    end

    it "requires directions" do
      recipe.directions = nil
      recipe.should_not be_valid
      recipe.errors[:directions].should eq(["can't be blank"])
    end

    it "requires ingredients" do
      recipe.ingredients = nil
      recipe.should_not be_valid
      recipe.errors[:ingredients].should eq(["can't be blank"])
    end

    it "requires source_url to be unique but allows nil" do
      recipe.source_url = '/test'
      recipe.save

      new_recipe = Factory.build(:recipe, :source_url => '/test')
      new_recipe.should_not be_valid
      new_recipe.errors[:source_url].should eq(["has already been taken"])

      new_recipe.source_url = nil
      new_recipe.should be_valid
    end

    it "requires total time to be a time" do
      recipe.total_time = 'a long time'
      recipe.should_not be_valid
      recipe.errors[:total_time].should eq(["must be a time such as '1 hour' or '45 minutes'"])

      recipe.total_time = '15 mins'
      recipe.should be_valid

      recipe.total_time = 'one hour'
      recipe.should be_valid
    end
  end

  describe ".search" do
    it "returns an empty array if nothing is found" do
      Recipe.search('aoeu').should eq([])
    end

    it "returns recipes based on title, ingredients, or directions" do
      recipe.save
      Recipe.search('Pasta').first.should eq(recipe)
      Recipe.search('add salt').first.should eq(recipe)
      Recipe.search('pound spaghetti').first.should eq(recipe)
    end
  end

  describe "#favorite_for?" do
    it "returns true if the recipe is in the user's favorites" do
      fav = Factory(:favorite)
      user = fav.user
      fav.recipe.favorite_for?(user).should eq(true)
    end

    it "returns false if the recipe is not in the user's favorites" do
      recipe.favorite_for?(Factory.build(:user)).should eq(false)
    end
  end

  describe "#total_time" do
    it "outputs the time as a string" do
      recipe.total_time = 60
      recipe.total_time.should eq ('1 min')
    end

    it "stores the time as an integer" do
      recipe.total_time = '1 min'
      recipe.total_time_before_type_cast.should eq(60)
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
end
