class AddTargetWeightFromUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :target_weight, :decimal, precision: 4, scale: 1, default: 0.0
  end
end
