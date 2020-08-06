class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.integer :point, default: 0
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
