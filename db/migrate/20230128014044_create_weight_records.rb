class CreateWeightRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :weight_records do |t|
      t.uuid :user_id
      t.decimal :weight

      t.timestamps
    end

    add_foreign_key :weight_records, :users
    add_index :weight_records, :user_id
  end
end
