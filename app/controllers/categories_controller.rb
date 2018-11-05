class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :record_changing
  before_action :load_category, only: [:show, :edit, :update, :destroy]


  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create

    if current_admin_user
      @category = current_admin_user.categories.new(category_params)
    elsif current_user
      @category = current_user.categories.new(category_params)
    else
      render :new
    end
    redirect_to categories_path if @category.save
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy unless @category.locked?
    redirect_to categories_path
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
