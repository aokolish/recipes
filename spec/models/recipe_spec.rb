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

    #it "finds a recipe by title" do
    #  result = Recipe.search "Scrambled Eggs"
    #  result.should include(@from_db)
    #end

    #it "finds a recipe by author" do
    #  result = Recipe.search "Alex"
    #  result.should include(@from_db)
    #end

    #it "finds a recipe by directions" do
    #  result = Recipe.search "cook eggs in a"
    #  result.should include(@from_db)
    #end

    #it "finds a recipe by ignredients" do
    #  result = Recipe.search "sausage basil"
    #  result.should include(@from_db)
    #end

    #it "returns an empty array for a bogus search" do
    #  result = Recipe.search "adsfasdfasdf"
    #  result.should be_empty
    #end

    #it "handles exception raised by invalid queries" do
    #  # some queries are not allowed such as '*' by the external api
    #  result = Recipe.search "*"
    #  # result.should be_empty
    #end

    #it "should update search index after destroying a recipe" do
    #  create_another_recipe
    #  result = Recipe.search "Anonymous"
    #  result.should include(@other_recipe) 

    #  recipe = Recipe.last
    #  recipe.destroy

    #  result = Recipe.search "Anonymous"
    #  result.should_not include(@other_recipe)
    #end

    #it "should update search index after saving a recipe" do
    #  create_another_recipe
    #  result = Recipe.search "Anonymous"
    #  result.should include(@other_recipe)

    #  # update and search based on updated field
    #  recipe = Recipe.last
    #  recipe.author = 'Captain America'
    #  recipe.save

    #  result = Recipe.search "Captain America"
    #  result.should include(@other_recipe)
    #end

    def create_another_recipe
      @other_recipe = Recipe.create( :title => "Grilled Cheese", :author => "Anonymous", 
                                  :directions => "put cheese on bread|put on grill", :ingredients => "bread|cheese")
    end
  end
end
