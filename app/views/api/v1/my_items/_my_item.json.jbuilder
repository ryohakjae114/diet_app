json.extract! my_item, :id, :created_at, :updated_at
json.url api_v1_my_item_url(my_item, format: :json)
