json.extract! item, :id, :name, :kcal, :protein, :fat, :carb, :df, :around_qty, :unit, :weight, :created_at, :updated_at
json.url api_v1_item_url(item, format: :json)
