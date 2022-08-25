class AddItemNumberToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :item_number, :integer
  end
end
