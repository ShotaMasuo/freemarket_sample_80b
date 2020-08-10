class AddCustomerIdToCreditCards < ActiveRecord::Migration[6.0]
  def change
    add_column :credit_cards, :customer_id, :string
    add_column :credit_cards, :card_id, :string
  end
end
