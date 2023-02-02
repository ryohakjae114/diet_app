class MySetRecipe < ApplicationRecord
  belongs_to :my_set
  belongs_to :recipe

  validates :count, numericality: { less_than_or_equal_to: 100 }
end
