class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: :likes_count

  validates :user_id, uniqueness: {
    scope: :article_id,
    message: "は同じ投稿に2回以上いいねはできません",
  }
end
