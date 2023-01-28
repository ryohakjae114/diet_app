json.extract! meal, :id, :user_id, :date, :timing, :comment, :created_at, :updated_at
json.url meal_url(meal, format: :json)
