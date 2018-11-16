class AddSlugColumnToWallpapers < ActiveRecord::Migration[5.2]
  def change
    add_column :wallpapers, :slug, :string
    add_index :wallpapers, :slug
  end
end
