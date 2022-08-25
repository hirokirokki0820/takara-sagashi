class AddItemPresenceToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :item_state, :string
  end
end
