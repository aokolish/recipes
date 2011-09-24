require 'spec_helper'

describe "authentication" do

  it "requires you to log in for these routes" do
    routes = [new_recipe_path, import_recipes_path]
    require_authentication(routes)
  end 
  
  def require_authentication(routes)
    routes.each do |route|
      visit route
      current_path.should eq(login_path)
      page.should have_content("Please log in") 
    end
  end
end