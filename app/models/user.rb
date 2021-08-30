class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  before_create :default_image

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_one_attached :avatar

  has_many :articles, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article

  has_many :keeps, dependent: :destroy
  has_many :kept_articles, through: :keeps, source: :article

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
  validates :email, { uniqueness: { case_sensitive: false } }

  validate :avatar_check

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
      user.profile = "ゲストユーザーです。"
    end
  end

  def default_image
    unless self.avatar.attached?
      self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "event_default.png")), filename: "event_default.png",
                         content_type: "image/png")
    end
  end

  def avatar_check
    return unless avatar.attached?

    if !avatar.content_type.in?(%('image/jpeg image/png image/jpg'))
      errors.add(:avatar, "はjpeg, png, jpgが保存可能です")
    elsif avatar.attachment.byte_size >= 5.megabytes
      errors.add(:avatar, "には最大5MBまでの画像が登録できます")
    end
  end
end
