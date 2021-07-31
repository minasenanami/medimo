class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :articles, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article

  has_many :keeps, dependent: :destroy
  has_many :kept_articles, through: :keeps, source: :article

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
end
