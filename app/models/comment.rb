class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :wallpaper

  validates :text, presence: true, length: { maximum: 1000 }
  validates :commentable, :wallpaper, presence: true

  paginates_per 20
  max_paginates_per 20
end
