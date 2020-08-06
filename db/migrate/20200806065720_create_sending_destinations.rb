class CreateSendingDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :sending_destinations do |t|
      t.string :first_name, null: false
      t.string :family_name, null: false
      t.string :first_name_kana, null: false
      t.string :family_name_kana, null: false
      t.integer :post_code, null: false
      t.string :prefecture_code, null: false
      t.string :city, null: false
      t.string :town, null: false
      t.string :building, null: true
      t.string :tell, null: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
