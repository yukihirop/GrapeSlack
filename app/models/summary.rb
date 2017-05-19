class Summary < ApplicationRecord
  belongs_to :user
  has_many :contents
end
