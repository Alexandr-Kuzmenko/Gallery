class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, ImageUploader
  validates :email, :password, presence: true
  validates :email, :nickname, uniqueness: true
  validates :password, confirmation: true, length: { in: 6..20 }
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  after_create { |admin| admin.send_reset_password_instructions }
  has_many :categories, as: :categorized
  #has_many :comments
  def password_required?
    new_record? ? false : super
  end
end
