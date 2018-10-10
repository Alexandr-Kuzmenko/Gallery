class AddColumnsToWallpapers < ActiveRecord::Migration[5.2]
  def change
    add_column :wallpapers, :category_id, :integer
  end
end
