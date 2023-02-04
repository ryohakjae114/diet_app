class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.uuid :user_id, null: false
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :favorites, [:user_id, :post_id], unique: true
  end
end
