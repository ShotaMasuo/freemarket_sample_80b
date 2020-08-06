class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.integer :card_number, null:false, unique: true
      t.integer :expiration_year, null: false
      t.integer :expiration_month, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
