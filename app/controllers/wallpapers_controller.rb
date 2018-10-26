class WallpapersController < ApplicationController
  skip_before_action :authenticate_user! || :authenticate_admin_user!, only: [:index, :show]
  before_action :load_categories, only: [:new, :create, :edit, :update]
  def index
    @wallpapers = Wallpaper.all
  end

  def show
    load_wallpaper
  end

  def new
    @wallpaper = Wallpaper.new
  end

  def edit
    load_wallpaper
  end

  def create
    @wallpaper = Wallpaper.new(wallpaper_params)
    @wallpaper.save ? redirect_to(wallpapers_path) : (render :new)
  end

  def update
    @wallpaper = load_wallpaper
    @wallpaper.update_attributes(wallpaper_params) ? redirect_to(wallpapers_path) : (render :edit)
  end

  def destroy
    @wallpaper = load_wallpaper
    @wallpaper.destroy
    redirect_to wallpapers_path
  end

  def fullsize
    @wallpaper = Wallpaper.find(params[:id])
  end

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
