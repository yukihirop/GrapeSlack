class Summary < ApplicationRecord
  belongs_to :user
  has_many :contents, dependent: :destroy
  accepts_nested_attributes_for :contents
end
