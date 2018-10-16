class Wallpaper < ApplicationRecord
  belongs_to :category
  has_many :posts
  mount_uploader :image, ImageUploader
end
