class Like < ApplicationRecord
  validates :user, presence: true
  validates :wallpaper, presence: true
  validates_uniqueness_of :user, scope: :wallpaper
  belongs_to :wallpaper, counter_cache: true
  belongs_to :user
end
