class ChangeDataWeightToWeightRecords < ActiveRecord::Migration[6.0]
  def change
    change_column :weight_records, :weight, :decimal, precision: 6, scale: 2, default: 0.0
  end
end
