class Meal < ApplicationRecord
  belongs_to :user
  has_many :meal_menus

  enum timing: { morning: 0, lunch: 1, dinner: 2, other: 3}

  validates :date,   presence: true, uniqueness: { scope: :timing }
  validates :timing, presence: true
  validates :comment,length: { maximum: 200 }

  def total_nutrients
    nutrients = { kcal: 0.0, protein: 0.0, carb: 0.0, fat: 0.0, df: 0.0 }

    self.meal_menus.each do |menu|
      nutrients[:kcal]    += menu.recipe.kcal    * menu.count
      nutrients[:protein] += menu.recipe.protein * menu.count
      nutrients[:carb]    += menu.recipe.carb    * menu.count
      nutrients[:fat]     += menu.recipe.fat     * menu.count
      nutrients[:df]      += menu.recipe.df      * menu.count
    end

    logger.debug(nutrients[:protein])
    return nutrients
  end
end
