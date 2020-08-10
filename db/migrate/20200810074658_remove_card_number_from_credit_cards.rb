class RemoveCardNumberFromCreditCards < ActiveRecord::Migration[6.0]
  def change
    remove_column :credit_cards, :card_number, :integer
    remove_column :credit_cards, :expiration_year, :integer
    remove_column :credit_cards, :expiration_month, :integer
  end
end
