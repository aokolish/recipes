class RecipesController < ApplicationController
  # GET /recipes
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  def show
    @recipe = Recipe.find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end
  
  # GET /recipes/import
  def import
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(params[:recipe])

    respond_to do |format|
      if @recipe.save
        redirect_to(@recipe, :notice => 'Recipe was successfully created.')
      else
        render :action => "new"
      end
    end
  end
  
  def create_from_import
    url = params[:recipe][:source_url]
    @recipe = Recipe.from_import(url)
    puts "recipe: #{@recipe}"
                          
    if @recipe.save
      redirect_to(@recipe, :notice => 'Recipe was successfully created.')
    else
      render :action => "import", :notice => 'Could not create a recipe from that url'
    end

  end

  # PUT /recipes/1
  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        redirect_to(@recipe, :notice => 'Recipe was successfully updated.')
      else
        render :action => "edit"
      end
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to(recipes_path)
  end
end
