class WallpapersController < ApplicationController
  #before_action :set_wallpaper, only: [:show, :edit, :update]
#=begin  
  def index
    @wallpapers = Wallpaper.all
    @cat_list = category_mass
    #@view_main_page = {}     

  end

  def show
    @wallpaper = Wallpaper.find(params[:id])
  end

  def new
    @wallpaper = Wallpaper.new
  end

  def edit
    @wallpaper = Wallpaper.find(params[:id])
  end

  def create
  	@wallpaper = Wallpaper.new(wallpaper_params)
    if @wallpaper.save
      redirect_to wallpapers_path
    else
      render :new
    end
  end

  def update
  	@wallpaper = Wallpaper.find(params[:id])
    if @wallpaper.update_attributes(wallpaper_params)
  	  redirect_to wallpapers_path
  	else
  	  render :edit
  	end
  end
  
  def destroy
    @wallpaper = Wallpaper.find(params[:id])
    @wallpaper.destroy
    redirect_to wallpapers_path    
  end

  private
  def wallpaper_params
    params.require(:wallpaper).permit(:title, :category, :image)
  end

  def category_mass
    categ = []
    Wallpaper.all.each { |wallpaper| categ << wallpaper.category }
    categ.uniq.sort
  end

end
