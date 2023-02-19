class ChangeDailyKcalToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :diet_goals, :daily_kcal, :decimal, precision: 6, scale: 1, default: 0.0
  end
end
