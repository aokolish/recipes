require 'spec_helper'

describe Recipe do
  describe "#search" do
    before(:all) do
      # Recipe.tanker_reindex
      # Factory(:recipe)
      @recipe = Recipe.create(  :title => "Scrambled Eggs", 
                                :author => "Alex", 
                                :directions => "whisk eggs|slowly cook eggs in a non-stick pan", 
                                :ingredients => "eggs|sausage|basil")
      @from_db = Recipe.find_by_title "Scrambled Eggs"
    end

    it "finds a recipe by title" do
      result = Recipe.search_tank "Scrambled Eggs"
      result.should include(@from_db)
    end
    
    it "finds a recipe by author" do
      result = Recipe.search_tank "Alex"
      result.should include(@from_db)
    end
    
    it "finds a recipe by directions" do
      result = Recipe.search_tank "cook eggs in a"
      result.should include(@from_db)
    end
    
    it "finds a recipe by ignredients" do
      result = Recipe.search_tank "sausage basil"
      result.should include(@from_db)
    end
    
    it "returns an empty array for a bogus search" do
      result = Recipe.search_tank "adsfasdfasdf"
      result.should be_empty
    end
    
    it "handles exception raised by invalid queries" do
      # some queries are not allowed such as '*' by the external api
    end

    it "should update search index after destroying a recipe" do
      create_another_recipe
      result = Recipe.search_tank "Anonymous"
      result.should include(@other_recipe) 
      
      recipe = Recipe.last
      recipe.destroy
      
      result = Recipe.search_tank "Anonymous"
      result.should_not include(@other_recipe)
    end

    it "should update search index after saving a recipe" do
      create_another_recipe
      result = Recipe.search_tank "Anonymous"
      result.should include(@other_recipe)
      
      # update and search based on updated field
      recipe = Recipe.last
      recipe.author = 'Captain America'
      recipe.save
      
      result = Recipe.search_tank "Captain America"
      result.should include(@other_recipe)
    end
    
    it "should handle exception when records are not found in the db" do
      # Not sure what to do about this, but this happened a lot during testing...
      # ActiveRecord::RecordNotFound:
      # Couldn't find all Recipes with IDs (980190966, 165) (found 1 results, but was looking for 2)
    end
    
    def create_another_recipe
      @other_recipe = Recipe.create( :title => "Grilled Cheese", :author => "Anonymous", 
                                  :directions => "put cheese on bread|put on grill", :ingredients => "bread|cheese")
    end
  end
end