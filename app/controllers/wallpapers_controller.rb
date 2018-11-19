class WallpapersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_categories, only: [:new, :create, :edit, :update]
  before_action :load_wallpaper, only: [:show, :edit, :update, :destroy, :fullsize]

  def index
    @wallpapers = Wallpaper.all.order(:created_at).page(params[:page])
  end

  def show; end

  def new
    @wallpaper = Wallpaper.new
  end

  def edit; end

  def create
    @wallpaper = Wallpaper.new(wallpaper_params)
    if @wallpaper.save
      UserMailer.with(category: @wallpaper.category).list_for_new_wallpapers_recipients.deliver_now
      redirection
    else
      render :new
    end
  end

  def update
    if @wallpaper.update_attributes(wallpaper_params)
      redirection
    else
      render :edit
    end
  end

  def destroy
    @wallpaper.destroy
    redirection
  end

  def fullsize; end

  private

  def redirection
    current_admin_user ? redirect_to(admin_wallpapers_path) : redirect_to(wallpapers_path)
  end

  def wallpaper_params
    params.require(:wallpaper).permit(:title, :image, :category_id, :remote_image_url, :image_cached)
  end

  def load_wallpaper
    @wallpaper = Wallpaper.friendly.find(params[:id])
  end

  def load_categories
    @categories = Category.includes(:subscriptions).all
  end
  #
  #def like_proc
  #  @wallpaper.likes.action_like
  #end
end
