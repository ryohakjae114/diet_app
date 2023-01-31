json.extract! diary_comment, :id, :diary_id, :user_id, :text, :created_at, :updated_at
json.url diary_comment_url(diary_comment, format: :json)
