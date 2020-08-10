class Category < ApplicationRecord
  validates :name, presence: true

  has_many :items, through: :item_categories
end
