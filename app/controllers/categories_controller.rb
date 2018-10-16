class CategoriesController < ApplicationController
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
    if @category.locked == false
      @category.destroy
      redirect_to categories_path
    else
      redirect_to categories_path
    end
  end

  private

  def personal_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  # Locking category for admins to prevent deleting.
  def lock_category
    show
    @category.locked = true
  end

  def unlock_category
    show
    @category.locked = false
  end
end
