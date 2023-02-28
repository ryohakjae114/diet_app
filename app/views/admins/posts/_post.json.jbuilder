json.extract! post, :id, :user_id, :text, :created_at, :updated_at, :date
json.url post_url(post, format: :json)
