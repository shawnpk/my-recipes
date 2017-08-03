class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update]

  def show
  end

  def new
    @chef = Chef.new
  end

  def edit
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

  def update
    if @chef.update(chef_params)
      flash[:success] = 'Account successfully updated'
      redirect_to @chef
    else
      render :edit
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
