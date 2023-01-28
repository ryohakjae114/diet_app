json.extract! weight_record, :id, :user_id, :weight, :created_at, :updated_at
json.url weight_record_url(weight_record, format: :json)
