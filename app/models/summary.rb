class Summary < ApplicationRecord
  belongs_to :user
  has_many :contents, dependent: :destroy
  accepts_nested_attributes_for :contents
  before_save :remake_contents

  def remake_contents
    self.contents = Marshal.load(Marshal.dump(self.contents)).drop(1)
  end

end
