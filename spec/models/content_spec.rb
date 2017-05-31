require 'rails_helper'

describe Content, type: :model do

  describe 'association' do
    it { is_expected.to belong_to(:summary)}
  end

  describe 'validation' do
    it {is_expected.to validate_presence_of(:slack_url)}
    # validate_format_ofはshoulda-matchers v2からは使えない。
    it {is_expected.not_to allow_value('http://aiming.slack.com/archives/').for(:slack_url)}
  end

end