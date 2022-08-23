class AddItemGotUserToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :item_got_user, :string
  end
end
