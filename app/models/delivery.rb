class Delivery < ApplicationRecord
  validates :prefecture_code, presence: true
  validates :ship_days, presence: true
  validates :ship_way, presence: true
  validates :fee, presence: true

  belongs_to :item
  belongs_to :user
  belongs_to :sending_destination
end
