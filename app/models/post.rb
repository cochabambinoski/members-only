class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 28 }
  validates :text, presence: true, length: { maximum: 280 }

  belongs_to :user
  paginates_per 10
end
