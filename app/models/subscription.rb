class Subscription < ApplicationRecord
  validates :user, presence: true
  validates :category, presence: true
  validates_uniqueness_of :user, scope: :category
  belongs_to :category
  belongs_to :user
end
