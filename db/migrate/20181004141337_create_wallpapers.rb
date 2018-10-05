class CreateWallpapers < ActiveRecord::Migration[5.2]
  def change
    create_table :wallpapers do |t|
      t.string :title
      t.string :category
      t.string :image

      t.timestamps
    end
  end
end
