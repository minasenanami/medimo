class Article < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :status
  end

  enum status: {
    published: 0,
    draft: 1,
    closed: 2,
  }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :keeps, dependent: :destroy
  has_many :kept_users, through: :keeps, source: :user

  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  has_rich_text :content
  has_many_attached :images

  def liked_by?(user)
    likes.any? {|like| like.user_id == user.id }
  end

  def kept_by?(user)
    keeps.any? {|keep| keep.user_id == user.id }
  end
end
