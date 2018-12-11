class Category < ApplicationRecord
  belongs_to :categorized, polymorphic: true
  has_many :wallpapers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  extend FriendlyId
  friendly_id :name, use: :slugged

  paginates_per 5
  max_paginates_per 5

  validates :name, :categorized, presence: true
  validates :name, uniqueness: true
end
