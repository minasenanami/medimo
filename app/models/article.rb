class Article < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :content
    validates :status
  end

  enum status: {
    published: 0,
    draft: 1,
    closed: 2,
  }

  belongs_to :user
end
