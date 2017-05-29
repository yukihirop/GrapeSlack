require 'rails_helper'

describe Summary, type: :model do

  describe 'association' do
    it { is_expected.to belong_to(:user)}
    it { is_expected.to have_many(:contents) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:title) }
  end

end