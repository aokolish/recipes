require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  fixtures :recipes
  
  setup do
    @recipe = recipes(:one)
  end
  
  test "recipe attributes must not be empty" do
    recipe = Recipe.new
    assert recipe.invalid?
    assert recipe.errors[:title].any?
    assert recipe.errors[:author].any?
    assert recipe.errors[:ingredients].any?
    assert recipe.errors[:directions].any?
  end
  
  test "recipe is not valid without a unique source_url" do
    recipe = Recipe.new(:source_url => 'foo.com', :title => 'f', :author => 'asdf', :ingredients => 'asdf', :directions => 'asdf')
    assert !recipe.save
    assert_equal "has already been taken", recipe.errors[:source_url].join('; ')
  end
  
  test "total_time is stored as an integer and outputted as a string" do
    r = Recipe.first
    assert_equal String, r.total_time.class
    assert_equal Fixnum, r.total_time_before_type_cast.class
  end
  
  test "total_time can be set with an integer or a string" do
    @recipe.total_time = '1 hour'
    assert_equal 3600, @recipe.total_time_before_type_cast
    assert_equal '1 hr', @recipe.total_time
    
    @recipe.total_time = 3000
    assert_equal 3000, @recipe.total_time_before_type_cast
    assert_equal '50 mins', @recipe.total_time
  end
  
  test "directions are delimited by pipes and available as an array" do
    # this is a virtual attribute
    assert @recipe.directions =~ /\|/
    assert_equal Array, @recipe.directions_array.class
  end
  
  test "pipes in directions can be changed to newlines" do
    @recipe.change_pipes_to_newlines
    assert @recipe.directions =~ /\n\n/
  end
  
  test "before validation, breaks and newlines will be replaced by pipes" do
    @recipe.directions = "step1\n\nstep2<br><br />step3<br>\n  "
    @recipe.save
    
    # no more breaks/newlines
    assert_no_match /((\r\n)|\n|(<br>)|(<br \/>)|(<br\/>))+/i, @recipe.directions
    
    # for some reason, I have to save again to remove the last pipe
    @recipe.save
    # no pipes at beginning or end
    assert_no_match /(\A\||\|\z)/, @recipe.directions
    
    # there should be some pipes in there
    assert_not_nil @recipe.directions =~ /(\|)/
  end
end
