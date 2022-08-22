class AddLoseColumnToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :lose, :boolean, default: false, null: false
  end
end
