json.extract! recipe, :id, :name, :item_id, :kcal, :weight, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
