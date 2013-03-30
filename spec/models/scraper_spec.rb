require 'spec_helper'

describe "Scraper" do
  let(:scraper) { Scraper.new }

  it "scrapes foodnetwork" do
    recipe = scraper.scrape("http://www.foodnetwork.com/example")
    recipe.valid?
    recipe.title.should eq("Strawberries-and-Cream Tart")
    recipe.author.should eq("Recipe courtesy of Food Network Magazine")
    recipe.source_url.should eq("http://www.foodnetwork.com/example")
    recipe.total_time.should eq("1 hr 25 mins")
    recipe.yield.should eq("6-8 servings")
    recipe.ingredients.should include("2\ttablespoons vegetable oil\r|1\tlarge egg plus 1 egg yolk")
    recipe.directions.should include("Make the crust: Whisk the vegetable oil, egg yolk, milk and vinegar in a bowl. Pulse the flour, baking powder, sugar and salt in a food processor to combine; add the butter and pulse until the mixture looks like coarse meal. Add the milk mixture and pulse once or twice, just to moisten the flour.\r|Transfer the dough")
  end

  it "scrapes cookingchanneltv" do
    recipe = scraper.scrape("http://www.cookingchanneltv.com/example")
    recipe.valid?
    recipe.title.should eq("Monkey Tail Banana Cake")
    recipe.author.should eq("Recipe courtesy Sara A. Hodgson for 2011 Cooking Channel, LLC. All Rights Reserved.")
    recipe.source_url.should eq("http://www.cookingchanneltv.com/example")
    recipe.total_time.should eq("2 hrs 8 mins")
    recipe.yield.should eq("12 servings")
    recipe.ingredients.should include("3/4 cup  unsalted butter, at room temperature|1 1/2 cups packed light  brown sugar|")
    recipe.directions.should include("For the cake: Preheat the oven to 350 degrees F. Grease 3 (9-inch) round cake pans with cooking spray. In large bowl, cream together the butter, light brown sugar, and granulated sugar until light and fluffy. Mix in the eggs, mashed bananas, sour cream, and vanilla until smooth.|In a separate bowl")
  end
end
