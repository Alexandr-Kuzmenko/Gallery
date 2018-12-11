class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :user, :category, presence: true
  validates_uniqueness_of :user, scope: :category
end
