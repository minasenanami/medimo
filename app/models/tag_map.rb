class TagMap < ApplicationRecord
  belongs_to :article
  belongs_to :tag

  with_options presence: true do
    validates :article_id
    validates :tag_id
  end
end
