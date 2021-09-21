class Article < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :status
    validates :content, presence: true, if: -> { status == "published" }
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

  def liked_by?(user)
    likes.any? {|like| like.user_id == user.id }
  end

  def kept_by?(user)
    keeps.any? {|keep| keep.user_id == user.id }
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_tag = Tag.find_or_create_by!(tag_name: new)
      self.tags << new_tag
    end
  end
end
