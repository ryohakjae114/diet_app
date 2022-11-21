class Recipe < ApplicationRecord
  has_many :recipe_items
  has_many :items, through: :recipe_items

  enum cook_at: { 一般料理: 0, 外食・市販: 1 }
  validates :img_url, presence: true
  validates :name, presence: true, uniqueness: true
end
