class Wallpaper < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  extend FriendlyId
  friendly_id :title, use: :slugged

  paginates_per 5
  max_paginates_per 10

  validates :title, presence: true
  validates :image, presence: true
end
