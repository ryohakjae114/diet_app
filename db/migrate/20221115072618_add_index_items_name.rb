class AddIndexItemsName < ActiveRecord::Migration[6.0]
  def change
    add_index :items, :name, unique: true
  end
end
