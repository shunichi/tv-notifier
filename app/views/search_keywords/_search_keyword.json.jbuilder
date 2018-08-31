json.extract! search_keyword, :id, :user_id, :keyword, :created_at, :updated_at
json.url search_keyword_url(search_keyword, format: :json)
