class Slack < ApplicationRecord
  has_many :summary
  has_secure_password
end
