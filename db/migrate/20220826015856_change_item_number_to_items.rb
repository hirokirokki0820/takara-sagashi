class ChangeItemNumberToItems < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :item_number, :string
  end
end
