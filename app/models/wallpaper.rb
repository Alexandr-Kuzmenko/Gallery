class Wallpaper < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  paginates_per 5
  max_paginates_per 10

  validates :title, :image, presence: true
end
