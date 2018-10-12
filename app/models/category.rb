class Category < ApplicationRecord
  belongs_to :user
  has_many :wallpapers, dependent: :destroy
end
