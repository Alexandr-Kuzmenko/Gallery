class Like < ApplicationRecord
  belongs_to :wallpaper, counter_cache: true
  belongs_to :user

  validates :user, :wallpaper, presence: true
  validates_uniqueness_of :user, scope: :wallpaper
end
