json.extract! content, :id, :first_name, :last_name, :slack_url, :slack_message, :summary_id, :created_at, :updated_at
json.url content_url(content, format: :json)
