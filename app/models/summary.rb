class Summary < ApplicationRecord
  belongs_to :user
  has_many :contents
  accepts_nested_attributes_for :contents
end
