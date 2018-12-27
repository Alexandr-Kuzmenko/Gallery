class WallpapersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_categories, only: [:new, :create, :edit, :update]
  before_action :load_wallpaper, only: [:show, :edit, :update, :destroy, :fullsize]

  def index
    @wallpapers = Wallpaper.all.order('likes_count DESC, title').page(params[:wallpapers_page])
  end

  def show; end

  def new
    @wallpaper = Wallpaper.new
  end

  def edit; end

  def create
    @wallpaper = Wallpaper.new(wallpaper_params)
    if @wallpaper.save
      list_for_notification
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

  def list_for_notification
    emails = @wallpaper.category.users.pluck(:email)
    emails.each { |email| UserMailer.with(category: @wallpaper.category).new_wallpaper_at_subs_category(email).deliver_now }
  end

  private

  def redirection
    unless request&.referer&.include?("/#{I18n.locale}/admin/parsing")
      current_admin_user ? redirect_to(admin_wallpapers_path) : redirect_to(wallpapers_path)
    end
  end

  def wallpaper_params
    params.require(:wallpaper).permit(:title, :category_id, :image, :image_cache, :remote_image_url)
  end

  def load_wallpaper
    @wallpaper = Wallpaper.friendly.find(params[:id])
  end

  def load_categories
    @categories = Category.includes(:subscriptions).all
  end

  def like_proc
    @wallpaper.likes.new
  end
end
