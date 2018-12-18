module WallpapersHelper
  def exist_like?(obj)
    @like = current_user.likes.find_by wallpaper: obj
  end
end
