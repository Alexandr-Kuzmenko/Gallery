class Wallpaper < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  extend FriendlyId
  friendly_id :title, use: :slugged

  paginates_per 5
  max_paginates_per 10

  validates :title, presence: true

  def self.prepare_notification_list(wallpaper)
    category = wallpaper.category
    emails = category.users.pluck(:email)
    emails.each { |email| UserMailer.with(category: category).new_wallpaper_at_subs_category(email).deliver_now }
  end
end
