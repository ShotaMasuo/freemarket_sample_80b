class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format:{ with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password, presence: true
  has_one :profile
  has_one :point
  has_one :credit_card
  has_many :favorites
  has_many :comments
  has_many :items
  has_many :sending_destinations
  has_many :purchases
  has_many :deliveries
end
