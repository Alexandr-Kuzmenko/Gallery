class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, :password, presence: true
  validates :password, confirmation: true, length: { in: 6..20 }
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  after_create { |admin| admin.send_reset_password_instructions }
  def password_required?
    new_record? ? false : super
  end
end
