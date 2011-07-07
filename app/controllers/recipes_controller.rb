class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end
  
  # GET /recipes/import
  def import
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe.change_pipes_to_newlines
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(params[:recipe])

    if @recipe.save
      Ingredient.parse_and_associate(params[:raw_ingredients], @recipe)
      redirect_to(@recipe, :notice => 'Recipe was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def create_from_import
    url = params[:recipe][:source_url]
    @recipe = Recipe.from_import(url)
                          
    if @recipe.save
      redirect_to(@recipe, :notice => 'Recipe was successfully created.')
    elsif @recipe.errors[:source_url] == ['has already been taken']
      redirect_to(import_recipes_url, :notice => "Sorry, that recipe has already been imported.")      
    else
      # really? there could be other errors!!
      # redirect_to(new_recipe_url, :notice => 'errors occured', :recipe => @recipe)
      redirect_to(import_recipes_url, :notice => "Sorry, there was a problem creating a recipe from #{url}. That site may not be supported at this time.")
    end

  end

  # PUT /recipes/1
  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update_attributes(params[:recipe])
      Ingredient.parse_and_associate(params[:raw_ingredients], @recipe)
      redirect_to(@recipe, :notice => 'Recipe was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to(recipes_path)
  end
end
