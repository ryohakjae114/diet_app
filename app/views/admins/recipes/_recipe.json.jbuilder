json.extract! recipe, :id, :img_url, :name, :protein, :fat, :carb, :df, :cook_at, :created_at, :updated_at, :kcal, :user_id
json.items do
  json.array! recipe.items
end
