class RemoveActivationIdFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :activation_id, :string
  end
end
