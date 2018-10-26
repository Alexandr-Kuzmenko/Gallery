class CategoriesController < ApplicationController
  skip_before_action :authenticate_user! || :authenticate_admin_user!, only: [:index, :show]
  before_action :personal_category, only: [:show, :edit, :update]
  before_action :load_categories, only: [:show, :edit, :update]

  def index
    @categories = Category.all
  end

  def show
    load_categories
  end

  def new
    @category = Category.new
  end

  def edit
    personal_category
  end

  def create
    @category = current_user.categories.new(category_params)
    @category.save ? redirect_to(categories_path) : (render :new)
  end

  def update
    load_categories
    @category.update_attributes(category_params) ? redirect_to(categories_path) : (render :edit)
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

  def load_categories
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
