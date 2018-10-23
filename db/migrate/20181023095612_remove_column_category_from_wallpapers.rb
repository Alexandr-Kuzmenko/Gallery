class RemoveColumnCategoryFromWallpapers < ActiveRecord::Migration[5.2]
  def change
    remove_column :wallpapers, :category, :string
  end
end
