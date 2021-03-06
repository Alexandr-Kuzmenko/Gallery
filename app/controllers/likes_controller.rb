class LikesController < ApplicationController
  before_action :authenticate_user!
  after_action :record_changing, only: [:new]

  def new
    @wallpaper = Wallpaper.friendly.find(params[:wallpaper_id])
    check_like ? nail_like : put_like
    redirect_back fallback_location: wallpapers_url
  end

  private

  # methods for the button: "like"

  def put_like
    @like = current_user.likes.create(wallpaper: @wallpaper)
    @record_action = 'likes'
  end

  def nail_like
    @like.destroy
    @record_action = 'dislikes'
  end

  def check_like
    @like = current_user.likes.find_by wallpaper: @wallpaper
  end

  # end of methods for the button: "like"
end
