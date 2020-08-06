class SendingDestination < ApplicationRecord
  validates :first_name, presence: true
  validates :family_name, presence: true
  validates :first_name_kana, presence: true
  validates :family_name_kana, presence: true
  validates :post_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :town, presence: true

  has_many :deriveries
  belongs_to :user
end
