class RecipesController < ApplicationController
  before_action :get_recipe, only: [:show]

  def index
    @recipes = Recipe.all
  end

  def show

  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first

    if @recipe.save
      flash[:success] = 'Your recipe has been successfullly created.'
      redirect_to @recipe
    else
      render :new
    end
  end

  private
  def get_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
