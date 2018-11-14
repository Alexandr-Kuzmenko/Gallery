class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all.order(:created_at).page(params[:page])
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
    raise NameBlank unless category.name
    redirect_to categories_path if category.save
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
