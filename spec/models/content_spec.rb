require 'rails_helper'

describe Content, type: :model do

  describe 'association' do
    it { is_expected.to belong_to(:summary)}
  end

  describe 'association' do
    it {is_expected.to validate_presence_of(:slack_url)}
  end

end