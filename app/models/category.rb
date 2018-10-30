class Category < ApplicationRecord
  validates :name, presence: true
  belongs_to :categorized, polymorphic: true
  has_many :wallpapers, dependent: :destroy
end
