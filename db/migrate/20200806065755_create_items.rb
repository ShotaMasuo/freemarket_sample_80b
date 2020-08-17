class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false, index: true
      t.integer :price, null: false
      t.string :size, null: true
      t.integer :condition, null: false
      t.string :brand, null: true
      t.integer :stage, null: false, default: "0"
      t.text :detail, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
