class CreateMySets < ActiveRecord::Migration[6.0]
  def change
    create_table :my_sets do |t|
      t.uuid   :user_id, null: false
      t.string :name

      t.timestamps
    end
    add_foreign_key :my_sets, :users
    add_index :my_sets, :user_id
  end
end
