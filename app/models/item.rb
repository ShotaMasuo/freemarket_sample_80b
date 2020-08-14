class Item < ApplicationRecord

  enum fee: {
    '送料込み（出品者が負担）':1, '着払い（購入者が負担）':2
  }

  enum condition: {
    '新品、未使用':1, '未使用に近い':2, '目立った傷や汚れなし':3, 'やや傷や汚れあり':4, '傷や汚れあり':5, '全体的に状態が悪い':6 
  }

  enum delivery_date: {
    '1~2日で発送':1, '2~3日で発送':2, '4~7日で発送':3
  }

  validates :name, presence: true
  validates :price, presence: true
  validates :condition, presence: true
  validates :stage, presence: true
  validates :detail, presence: true

  has_many :favorites
  has_many :comments
  has_many :images, dependent: :destroy
  has_one :purchase
  has_one :delivery
  belongs_to :category
  belongs_to :user

  accepts_nested_attributes_for :images, allow_destroy: true
end
