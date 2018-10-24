class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, :password, presence: true
  validates :password, confirmation: true, length: { in: 6..20 }
  has_many :categories
  has_many :comments
end
