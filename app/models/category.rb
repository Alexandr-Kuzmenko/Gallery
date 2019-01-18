class Category < ApplicationRecord
  extend FriendlyId

  belongs_to :categorized, polymorphic: true
  has_many :wallpapers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates :name, :categorized, presence: true
  validates :name, uniqueness: true

  friendly_id :name, use: :slugged

  paginates_per 4
  max_paginates_per 4
end
