class CategoriesController < ApplicationController

  #before_action :personal_category, only: %i[show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    personal_category
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = personal_category
    @category.destroy if @category.locked == false
    redirect_to categories_path
  end

  private

  def personal_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
