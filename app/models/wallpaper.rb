class Wallpaper < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, :image, presence: true
end
