class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

    validates :first_name, presence: true
    validates :family_name, presence: true
    validates :first_name_kana, presence: true
    validates :family_name_kana, presence: true
    validates :post_code, presence: true, length: { minimum: 8 }, format:{ with:/\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_code, presence: true
    validates :city, presence: true
    validates :town, presence: true

    has_many :deliveries
    belongs_to :user, optional: true

end
