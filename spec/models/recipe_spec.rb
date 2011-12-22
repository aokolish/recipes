require 'spec_helper'

describe Recipe do
  describe "#search" do
    before(:all) do
      Recipe.destroy_all
      Recipe.create(  :title => "Scrambled Eggs", 
                      :author => "Alex", 
                      :directions => "whisk eggs|slowly cook eggs in a non-stick pan", 
                      :ingredients => "eggs|sausage|basil")
      @from_db = Recipe.find_by_title "Scrambled Eggs"
    end

    it "finds a recipe by title", :broken => true do
      result = Recipe.search "Scrambled Eggs"
      result.should include(@from_db)
    end

    it "finds a recipe by author", :broken => true do
      result = Recipe.search "Alex"
      result.should include(@from_db)
    end

    it "finds a recipe by directions", :broken => true do
      result = Recipe.search "cook eggs in a"
      result.should include(@from_db)
    end

    it "finds a recipe by ignredients", :broken => true do
      result = Recipe.search "sausage basil"
      result.should include(@from_db)
    end

    it "returns an empty array for a bogus search", :broken => true do
      result = Recipe.search "adsfasdfasdf"
      result.should be_empty
    end

    it "handles exception raised by invalid queries", :broken => true do
      # some queries are not allowed such as '*' by the external api
      result = Recipe.search "*"
      # result.should be_empty
    end

    it "should update search index after destroying a recipe", :broken => true do
      create_another_recipe
      result = Recipe.search "Anonymous"
      result.should include(@other_recipe) 

      recipe = Recipe.last
      recipe.destroy

      result = Recipe.search "Anonymous"
      result.should_not include(@other_recipe)
    end

    it "should update search index after saving a recipe", :broken => true do
      create_another_recipe
      result = Recipe.search "Anonymous"
      result.should include(@other_recipe)

      # update and search based on updated field
      recipe = Recipe.last
      recipe.author = 'Captain America'
      recipe.save

      result = Recipe.search "Captain America"
      result.should include(@other_recipe)
    end

    it "should handle exception when records are not found in the db", :broken => true do 
      # setup
      # api = IndexTank::Client.new Rails.configuration.index_tank_url
      # index = api.indexes Rails.configuration.indextank_index
      # 
      # # add a dummy document to the index that looks like a typical record
      # docid = "Recipe 1234"
      # text = ".This is a test"
      # index.document(docid).add({ :__any => text, :__id => "1234", :__type => "Recipe", :author => 'test', :directions => 'test', :title => 'test' })

      r = Recipe.last
      r.id = 4321
      r.update_tank_indexes     

      # TODO: WHY DOESN'T THIS RAISE AN ERROR WITH MY MONKEY PATCH REMOVED!?

      # ActiveRecord::RecordNotFound:
      # Couldn't find all Recipes with IDs (980190966, 165) (found 1 results, but was looking for 2)
      lambda {Recipe.search "Scrambled Eggs"}.should_not raise_error

      r = Recipe.search "This is a test"

      # return false

      # delete this fake record from the index to clean it up
      # index.delete_by_search "__any:test"
    end

    def create_another_recipe
      @other_recipe = Recipe.create( :title => "Grilled Cheese", :author => "Anonymous", 
                                  :directions => "put cheese on bread|put on grill", :ingredients => "bread|cheese")
    end
  end
end
