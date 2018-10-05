class Wallpaper < ApplicationRecord
  mount_uploader :image, ImageUploader
end
