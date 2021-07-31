class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, uniqueness: {
    scope: :article_id,
    message: "は同じ投稿に2回以上いいねはできません",
  }
end
