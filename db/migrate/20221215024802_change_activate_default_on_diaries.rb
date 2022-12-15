class ChangeActivateDefaultOnDiaries < ActiveRecord::Migration[6.0]
  def change
    change_column :diaries, :activate, :boolean, default: true
  end
end
