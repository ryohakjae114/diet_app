json.extract! recipe, :id, :img_url, :name, :protein, :fat, :carb, :df, :type, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
