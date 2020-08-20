class CreditCard < ApplicationRecord
  validates :customer_id, presence: true
  validates :card_id, presence: true

  belongs_to :user
end
