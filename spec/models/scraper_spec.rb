require 'spec_helper'

describe "Scraper" do
  let(:scraper) { Scraper.new }

  it "scrapes foodnetwork", vcr: true do
    url = "http://www.foodnetwork.com/recipes/ina-garten/strawberry-tarts-recipe/index.html"
    recipe = scraper.scrape(url)
    recipe.valid?
    recipe.title.should eq("Strawberry Tarts")
    recipe.author.should eq("Ina Garten")
    recipe.source_url.should eq(url)
    recipe.total_time.should eq("2 hr 0 min")
    recipe.yield.should eq("4 tarts")
    recipe.ingredients.should include(
      "1 1/4 cups all-purpose flour\r|3 tablespoons sugar\r|1/2 teaspoon kosher salt\r|6 tablespoons")
    recipe.directions.should include(
      "Combine the flour, sugar, and salt in a small bowl and place in the freezer for 30 minutes.")
  end

  it "scrapes cookingchanneltv", vcr: true do
    url = "http://www.cookingchanneltv.com/recipes/monkey-tail-banana-cake-recipe/index.html"
    recipe = scraper.scrape(url)
    recipe.valid?
    recipe.title.should eq("Monkey Tail Banana Cake")
    recipe.author.should eq("Recipe courtesy Sara A. Hodgson for 2011 Cooking Channel, LLC. All Rights Reserved.")
    recipe.source_url.should eq(url)
    recipe.total_time.should eq("2 hr 8 min")
    recipe.yield.should eq("12 servings")
    recipe.ingredients.should include("3/4 cup  unsalted butter, at room temperature|1 1/2 cups packed light  brown sugar|")
    recipe.directions.should include("For the cake: Preheat the oven to 350 degrees F. Grease 3 (9-inch) round cake pans with cooking spray. In large bowl, cream together the butter, light brown sugar, and granulated sugar until light and fluffy. Mix in the eggs, mashed bananas, sour cream, and vanilla until smooth.|In a separate bowl")
  end
end
