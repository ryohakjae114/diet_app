class AddColumnsToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :unit, :string
    add_column :items, :weight, :decimal
  end
end
