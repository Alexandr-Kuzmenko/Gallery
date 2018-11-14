class Category < ApplicationRecord
  belongs_to :categorized, polymorphic: true
  has_many :wallpapers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true
end
