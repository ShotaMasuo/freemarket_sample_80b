class Item < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :condition, presence: true
  validates :stage, presence: true
  validates :detail, presence: true

  has_many :favorites
  has_many :comments
  has_many :images
  has_one :purchase
  has_one :delivery
  belongs_to :categories
  belongs_to :user
end
