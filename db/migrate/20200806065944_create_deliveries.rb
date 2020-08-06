class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :prefecture_code, null: false
      t.integer :ship_days, null: false
      t.integer :ship_way, null: false
      t.integer :fee, null: false
      t.references :item, foreign_key: true, null: false
      t.references :buyer, foreign_key: {to_table: :users}, null: false
      t.references :sending_destination, foreign_key: true, null: false
      t.timestamps
    end
  end
end
