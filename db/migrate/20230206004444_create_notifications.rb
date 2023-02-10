class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|

      t.uuid :visitor_id, null: false
      t.uuid :visited_id, null: false
      t.integer :favorite_id
      t.integer :post_comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :post_comment_id
    add_index :notifications, :favorite_id
  end
end
