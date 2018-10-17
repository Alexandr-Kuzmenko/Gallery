class Wallpaper < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :posts
end
