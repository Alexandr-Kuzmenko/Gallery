class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend FriendlyId

  has_many :categories, as: :categorized
  has_many :subscriptions, dependent: :destroy
  has_many :follows, through: :subscriptions, source: :category
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :activities, dependent: :nullify

  validates :email, presence: true
  validates :password, confirmation: true, length: { in: 6..20 }, on: :create
  validates :password, confirmation: true, allow_blank: true, on: :update
  validates :email, uniqueness: true
  validates :nickname, length: { in: 1..20 }, allow_blank: true
  validates :nickname, uniqueness: { case_sensitive: false }, allow_blank: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  friendly_id :nickname, use: :slugged

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.token = auth.credentials.token
      # user.expires = auth.credentials.expires
      # user.expires_at = auth.credentials.expires_at
      # user.refresh_token = auth.credentials.refresh_token
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_oauth2_data"] && session["devise.google_oauth2_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
