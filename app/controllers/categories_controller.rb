class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    load_category
    #@list = @category.wallpapers.find(params[:catefory_id])
    #@category = id
    @name = current_user.categories.find(params[:id]).name ? @name = current_user.categories.find(params[:id]).name : @name = 'nothing'
  end

  def new
    @category = Category.new
  end

  def edit
    load_category
  end

  def create
    @category = Category.new(category_params)
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
    @category = Category.find(params[:id])
    #if current_user.id == @category.user_id
      @category.destroy
      redirect_to categories_path
    #else
    #  redirect_to categories_path
    #end
  end

  private
  
  def category_params
    params.require(:category).permit(:name, :user_id, :locked)
  end

  def load_category
    @category = Category.find(params[:id])
  end
end
