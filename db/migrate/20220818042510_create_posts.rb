class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id: :string do |t|
      t.string :title

      t.timestamps
    end
  end
end
