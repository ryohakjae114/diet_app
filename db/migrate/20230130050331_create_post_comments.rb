class CreatePostComments < ActiveRecord::Migration[6.0]
  def change
    create_table :post_comments do |t|
      t.references :post, null: false, foreign_key: true
      t.uuid :user_id, null: false
      t.string :text

      t.timestamps
    end

    add_foreign_key :post_comments, :users
    add_index :post_comments, :user_id
  end
end
