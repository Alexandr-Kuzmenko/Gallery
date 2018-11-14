class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :categories, as: :categorized
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :activities

  validates :email, presence: true
  validates :password, confirmation: true, length: { in: 6..20 }, on: :create
  validates :password, confirmation: true, allow_blank: true, on: :update
  validates :email, uniqueness: true
end
