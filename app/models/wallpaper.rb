class Wallpaper < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :title, :image, presence: true
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
