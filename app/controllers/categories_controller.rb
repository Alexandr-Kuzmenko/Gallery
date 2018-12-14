class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all.order('wallpapers_count DESC, name').page(params[:page])
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    user = current_admin_user || current_user
    render :new unless user
    category = user.categories.new(category_params)
    # raise NameBlank unless category.name
    category.save ? redirection : (render :new)
    end

  def update
    if @category.update_attributes(category_params)
      redirection
    else
      render :edit
    end
  end

  def destroy
    @category.destroy unless @category.locked?
    redirect_to categories_path
  end

  private

  def redirection
    current_admin_user ? redirect_to(admin_categories_path) : redirect_to(categories_path)
  end

  def load_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :locked)
  end
end
