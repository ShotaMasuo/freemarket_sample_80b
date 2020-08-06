class Comment < ApplicationRecord
  validates :comment, presence: true

  belongs_to :item
  belongs_to :user
end
