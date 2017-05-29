require 'rails_helper'

describe User, type: :model do

  describe 'association' do
    it { is_expected.to have_many(:summaries) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name)}
    it { is_expected.to validate_presence_of(:last_name)}
    it { is_expected.to validate_presence_of(:profile_img_url)}
    it { is_expected.to validate_presence_of(:email)}
    it { is_expected.to validate_presence_of(:password)}
    it { is_expected.to validate_presence_of(:provider)}
    it { is_expected.to validate_presence_of(:uid)}
    it { is_expected.to validate_presence_of(:name)}
  end

end