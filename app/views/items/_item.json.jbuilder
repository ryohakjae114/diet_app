json.extract! item, :id, :name, :kcal, :protein, :fat, :carb, :df, :around_qty, :created_at, :updated_at
json.url item_url(item, format: :json)
