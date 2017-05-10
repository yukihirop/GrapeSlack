json.extract! slack, :id, :first_name, :last_name, :email, :password_digest, :profile_img_url, :created_at, :updated_at
json.url slack_url(slack, format: :json)
