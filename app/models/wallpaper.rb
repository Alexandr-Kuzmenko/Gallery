class Wallpaper < ApplicationRecord
  extend FriendlyId

  belongs_to :category, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, :image, :category_id, presence: true

  friendly_id :title, use: :slugged

  mount_uploader :image, ImageUploader

  paginates_per 6
  max_paginates_per 20
end
