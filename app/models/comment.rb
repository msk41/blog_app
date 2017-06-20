class Comment < ApplicationRecord
  belongs_to :post
  validates :name, presence: true, length: { maximum: 50 }
  validates :text, presence: true
end
