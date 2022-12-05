class RecipeItem < ApplicationRecord
  belongs_to :item
  belongs_to :recipe

  validate :required_either_kcal_or_weight
  validates :item_id, uniqueness: { scope: :recipe_id }

  private

  def required_either_kcal_or_weight
    # 演算子 ^ で排他的論理和（XOR）にしています
    # kcalかweightのどちらかの値があれば true
    # kcal、weightどちらも入力されている場合や入力されていない場合は false
    return if kcal.present? ^ weight.present?

    errors.add(:base, 'カロリーまたは重量のどちらか一方を入力してください')
  end
end
