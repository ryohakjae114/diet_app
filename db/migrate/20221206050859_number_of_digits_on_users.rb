class NumberOfDigitsOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :height, :decimal, precision: 8, scale: 3, default: 0.0
    change_column :users, :weight, :decimal, precision: 8, scale: 3, default: 0.0
  end
end
