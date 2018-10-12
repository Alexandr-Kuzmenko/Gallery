class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #validates :email, presence: true
  #validates :password, presence: true #{ minimum: 8 }       
  has_many :categories
end
