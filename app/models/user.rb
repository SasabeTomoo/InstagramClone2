class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorite_feeds, through: :favorites, source: :feed
  has_many :feeds
  has_secure_password
  validates :image, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :name,     presence: true, length: { maximum: 30 }
  validates :email,    presence: true, length: { maximum: 255},
                         format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  mount_uploader :image, ImageUploader
end
