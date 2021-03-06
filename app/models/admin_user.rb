class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :categories, as: :categorized
  has_many :comments, as: :commentable, dependent: :destroy

  validates :email, presence: true
  validates :email, :nickname, uniqueness: true
  validates :password, confirmation: true, length: { in: 6..20 }, on: :create
  validates :password, confirmation: true, length: { in: 6..20 }, allow_blank: true, on: :update

  devise :database_authenticatable,
  :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  after_create { |admin| admin.send_reset_password_instructions }
  def password_required?
    new_record? ? false : super
  end
end
