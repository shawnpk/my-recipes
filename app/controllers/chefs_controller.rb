class ChefsController < ApplicationController
  before_action :set_chef, only: [:show]

  def show
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)

    if @chef.save
      flash[:success] = "Welcom #{@chef.chefname} to MyRecipes App"
      redirect_to @chef
    else
      render :new
    end
  end

  private
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end
end
