class Keep < ApplicationRecord
  belongs_to :user
  belongs_to :article

  belongs_to :article, counter_cache: :keeps_count

  validates :user_id, uniqueness: {
    scope: :article_id,
    message: "は同じ投稿に2回以上いいねはできません",
  }
end
