class AddDailyMomentumToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :daily_momentum, :decimal, precision: 3, scale: 2
  end
end
