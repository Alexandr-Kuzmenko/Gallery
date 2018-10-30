class WallpapersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_categories, only: [:new, :create, :edit, :update]
  before_action :load_wallpaper, only: [:show, :edit, :update, :destroy, :fullsize]

  def index
    @wallpapers = Wallpaper.all
  end

  def show; end

  def new
    @wallpaper = Wallpaper.new
  end

  def edit; end

  def create
    @wallpaper = Wallpaper.new(wallpaper_params)
    if @wallpaper.save
      redirect_to wallpapers_path
    else
      render :new
    end
  end

  def update
    if @wallpaper.update_attributes(wallpaper_params)
      redirect_to wallpapers_path
    else
      render :edit
    end
  end

  def destroy
    @wallpaper.destroy
    redirect_to wallpapers_path
  end

  def fullsize; end

  private

  def wallpaper_params
    params.require(:wallpaper).permit(:title, :category_id, :image)
  end

  def load_wallpaper
    @wallpaper = Wallpaper.find(params[:id])
  end

  def load_categories
    @categories = Category.all
  end
end
