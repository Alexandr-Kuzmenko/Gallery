class Comment < ApplicationRecord
  validates :text, presence: true, length: { maximum: 1000 }
  belongs_to :user
  #belongs_to :admin_user
  belongs_to :wallpaper
end
