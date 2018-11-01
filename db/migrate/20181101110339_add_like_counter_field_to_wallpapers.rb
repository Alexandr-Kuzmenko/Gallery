class AddLikeCounterFieldToWallpapers < ActiveRecord::Migration[5.2]
  def change
    add_column :wallpapers, :likes_count, :integer, default: 0
  end
end
