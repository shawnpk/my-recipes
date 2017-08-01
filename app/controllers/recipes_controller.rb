class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first

    if @recipe.save
      flash[:success] = 'Recipe has been created successfully.'
      redirect_to @recipe
    else
      render :new
    end
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = 'Recipe has been updated successfully.'
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:danger] = 'Recipe has been successfully deleted.'
    redirect_to recipes_path
   end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
