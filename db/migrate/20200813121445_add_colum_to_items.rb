class AddColumToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :prefecture, :string
    add_column :items, :fee, :integer
    add_column :items, :delivery_date, :integer
  end
end
