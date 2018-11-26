class AddWallpaperCounterFieldToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :wallpapers_count, :integer, default: 0
  end
end