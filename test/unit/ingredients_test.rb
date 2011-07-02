require 'test_helper'

class IngredientsTest < ActiveSupport::TestCase
  fixtures :ingredients
  
  setup do
    @salt_and_pepper = ingredients(:two)
    @chicken_broth = ingredients(:one)
    @eggs = ingredients(:three)
  end
  
  test "to_s works with nil attributes" do
    # nil preparation
    assert_equal "2 cu chicken broth", @chicken_broth.to_s
    # nil quantity/unit_of_measure
    assert_equal "salt and pepper, to taste", @salt_and_pepper.to_s
  end
  
  test "fractions, decimals, and integers are recognized as quantities" do
    ing = Ingredient.new
    ing.parse "1.5 cups kool aid"
    assert_equal ing.quantity, "1.5"
    assert ing.valid?
    
    ing = Ingredient.new
    ing.parse "3/4 teaspoon salt"
    assert_equal ing.quantity, "3/4"
    assert ing.valid?
    
    ing = Ingredient.new
    ing.parse "10 carrots, peeled and diced"
    assert_equal ing.quantity, "10"
    assert ing.valid?
  end
  
  test "if quantity is not present, it is stored as nil" do
    ing = Ingredient.new
    ing.parse "olive oil, to coat the pan"
    assert_equal nil, ing.quantity
  end
  
  test "when appropriate, first word will be stored as unit_of_measure" do
    ing = Ingredient.new
    ing.parse "olive oil, to coat the pan"
    assert_equal nil, ing.unit_of_measure
    
    ing = Ingredient.new
    ing.parse "10 pieces bacon"
    assert_equal nil, ing.unit_of_measure
    
    ing = Ingredient.new
    ing.parse "10 cups wine"
    assert_not_nil ing.unit_of_measure
    
    ing = Ingredient.new
    ing.parse "250 grams flour"
    assert_not_nil ing.unit_of_measure
    
    ing = Ingredient.new
    ing.parse "8 ounces beer"
    assert_not_nil ing.unit_of_measure
  end
  
  test "everything after the first comma is stored as 'preparation'" do
    ing = Ingredient.new
    ing.parse "8 ounces water, warmed"
    assert_equal "warmed", ing.preparation
    
    ing = Ingredient.new
    ing.parse "2 small green chiles, seeds removed, flesh chopped"
    assert_equal "seeds removed, flesh chopped", ing.preparation
  end
end
