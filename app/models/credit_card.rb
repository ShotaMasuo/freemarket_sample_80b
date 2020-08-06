class CreditCard < ApplicationRecord
  validates :card_number, presence: true, uniqueness: true
  validates :expiration_year, presence: true
  validates :expiration_month, presence: true
  
  belongs_to :user
end
