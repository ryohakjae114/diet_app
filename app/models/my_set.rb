class MySet < ApplicationRecord
  belongs_to :user
  has_many   :my_set_recipes

  validates :name, presence: true, uniqueness: { scope: :user }, length: { maximum: 20 }
end
