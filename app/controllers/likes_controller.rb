class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parent_wallpaper, only: [:new]

  def new
    check_like ? nail_like : put_like
    redirection
  end

  private

  # methods for the button: "like"

  def put_like
    @like = current_user.likes.create(wallpaper: @wallpaper)
  end

  def nail_like
    @like.destroy
  end

  def check_like
    @like = current_user.likes.find_by wallpaper: @wallpaper
  end

  # end of methods for the button: "like"

  def redirection
    current_admin_user ? redirect_to(admin_wallpaper_path(@wallpaper)) : redirect_to(wallpaper_path(@wallpaper))
  end

  def load_parent_wallpaper
    @wallpaper = Wallpaper.find(params[:wallpaper_id])
  end
end
