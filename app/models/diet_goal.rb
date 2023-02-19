class DietGoal < ApplicationRecord
  belongs_to :user

  validates :weight, presence: true, numericality: true
  validates :daily_kcal, presence: true, numericality: true
  validates :date,   presence: true

  def set_daily_kcal(user)
    diet_period = self.date - Date.today
    bml  =
    if user.gender == "male"
      665 + 9.6 * user.weight + 1.7 * user.height - 7 * user.age
    else
      66 + 13.7 * user.weight + 5 * user.height - 6.8 * user.age
    end

    daily_burned_calories    = bml * user.daily_momentum                 #1日の総消費カロリー

    weight_difference        = user.weight - self.weight          #体重差
    daily_calories_must_burn = (weight_difference * 7200) / diet_period.to_f  #マイナスしなければいけないカロリーの1日分
    logger.debug(daily_calories_must_burn)

    daily_calories_can_take  = daily_burned_calories - daily_calories_must_burn
    logger.debug(daily_calories_can_take)

    self.daily_kcal = daily_calories_can_take
    logger.debug(self.daily_kcal)
  end
end
