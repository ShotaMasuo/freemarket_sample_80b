class Profile < ApplicationRecord
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー一-龠]+\z/, message: "姓は全角で入力してください"}
  validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー一-龠]+\z/, message: "名は全角で入力してください"}
  validates :first_name_kana, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: "姓（ふりがな）は全角ひらがなで入力してください"}
  validates :family_name_kana, presence: true, format: { with: /\A[ぁ-んー－]+\z/, message: "名（ふりがな）は全角ひらがなで入力してください"}
  validates :birth_day, presence: true

  belongs_to :user
end
