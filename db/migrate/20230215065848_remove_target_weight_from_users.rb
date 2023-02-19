class RemoveTargetWeightFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :target_weight, :decimal
  end
end
