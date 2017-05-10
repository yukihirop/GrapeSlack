class Summary < ApplicationRecord
  belongs_to :slack
  has_many :content
end
