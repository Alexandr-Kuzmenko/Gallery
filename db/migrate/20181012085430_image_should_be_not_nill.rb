class ImageShouldBeNotNill < ActiveRecord::Migration[5.2]
  def change
    change_column_null :wallpapers, :image, false
  end
end
