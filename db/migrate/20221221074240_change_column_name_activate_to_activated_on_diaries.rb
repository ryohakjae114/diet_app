class ChangeColumnNameActivateToActivatedOnDiaries < ActiveRecord::Migration[6.0]
  def change
    rename_column :diaries, :activate, :activated
  end
end
