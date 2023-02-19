class AddDailyKcalToDietGoal < ActiveRecord::Migration[6.0]
  def change
    add_column :diet_goals, :daily_kcal, :integer
  end
end
