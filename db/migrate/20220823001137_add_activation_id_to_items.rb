class AddActivationIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :activation_id, :string
  end
end
