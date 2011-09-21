class RecipesController < ApplicationController

  def index
    @recipes = Recipe.paginate :page => params[:page], :per_page => 15, :order => 'created_at DESC'

    @recipes.each do |recipe|
      recipe.replace_pipes
    end
    
    @header = 'All Recipes'
  end
  
  # GET /recipes/search?search=some_search?page=2
  def search
    @recipes = Recipe.search(params[:search], params[:page])
    
    if @recipes.empty?
      flash.now[:notice] = "Sorry, you searched for '#{params[:search]}' and no results were found."
    end
    @header = 'Search Results'
    
    render 'index'
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
    @recipe.replace_pipes "\n\n", [:directions]
    @recipe.replace_pipes "\n", [:ingredients]
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(params[:recipe])

    if @recipe.save
      redirect_to(@recipe, :notice => 'Recipe was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def create_from_import
    url = params[:source_url]
    @recipe = Recipe.from_import(url)
                          
    respond_to do |format|                          
      if @recipe.save
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully created.') }
        format.mobile { redirect_to(@recipe, :notice => 'Recipe was successfully created.') }
      elsif @recipe.errors[:source_url] == ['has already been taken']
        format.html { redirect_to(import_recipes_url, :notice => "Sorry, that recipe has already been imported.") }      
        format.mobile { redirect_to(import_recipes_url, :notice => "Sorry, that recipe has already been imported.") }
      else
        format.html { redirect_to(import_recipes_url, :notice => "Sorry, there was a problem creating a recipe from #{url}. That site may not be supported at this time.") }
        format.mobile { redirect_to(import_recipes_url, :notice => "Sorry, there was a problem creating a recipe from #{url}. That site may not be supported at this time.") }
      end
    end
  end

  # PUT /recipes/1
  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update_attributes(params[:recipe])
      redirect_to(@recipe, :notice => 'Recipe was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, :notice => 'Recipe was deleted'
  end
end
