class CreateWallpapers < ActiveRecord::Migration[5.2]
  def change
    create_table :wallpapers do |t|
      t.string :title
      t.integer :category_id
      t.string :image, null: false

      t.timestamps
    end
  end
end
