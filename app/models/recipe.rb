class Recipe < ApplicationRecord
  has_many :recipe_items
  has_many :items, through: :recipe_items

  enum cook_at: { 一般料理: 0, 外食・市販: 1 }
  validates :name, presence: true, uniqueness: true
  # validates :protein, numericality: true
  # validates :carb,    numericality: true
  # validates :fat,     numericality: true
  # validates :df,      numericality: true

  def add_nutrients(recipe_item)
    increase = fluctuation_nutrients(recipe_item)

    #各栄養素の増量後の値
    after = { protein: self.protein + increase[:protein], carb: self.carb + increase[:carb],
                  fat: self.fat + increase[:fat],           df: self.df + increase[:df] }
    update_columns(protein: after[:protein], carb: after[:carb], fat: after[:fat], df: after[:df])
  end

  def sub_nutrients(recipe_item)
    decrease = fluctuation_nutrients(recipe_item)

    #各栄養素の減量後の値
    after = { protein: self.protein - decrease[:protein], carb: self.carb - decrease[:carb],
                  fat: self.fat - decrease[:fat],           df: self.df - decrease[:df] }
    update_columns(protein: after[:protein], carb: after[:carb], fat: after[:fat], df: after[:df])
  end

  #recipe_idとitem_idに紐ずく、中間テーブルのデータを返す
  def recipe_item(item)
    RecipeItem.find_by(recipe_id: self.id, item_id: item.id)
  end


  private

    def fluctuation_nutrients(recipe_item)
      item = recipe_item.item

      #乗数
      multiplier =
      if recipe_item.kcal
        (1.0 / item.kcal)  * recipe_item.kcal
      else
        (1.0 / item.weight)* recipe_item.weight
      end

      #各栄養素の増減量
      fluctuation  = {protein: item.protein*multiplier, carb: item.carb*multiplier,
                          fat: item.fat*multiplier,       df: item.df*multiplier }
    end
end
