require 'rails_helper'

describe 'Sidebar' do

  let(:user) { User.last }

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
  end

  subject { page }

  context '表示確認' do

    # [参考] http://qiita.com/maangie/items/4522fb16a0fd78fd150e
    it 'リンクの確認' do
      is_expected.to have_link(text: I18n.t('user.profile.title'),         href:user_profile_path(user.nickname))
      is_expected.to have_link(text: I18n.t('user.others_summaries.title'),href:user_others_summaries_path(user.nickname))
      is_expected.to have_link(text: I18n.t('user.summaries.title'),       href:summaries_path(user.nickname))
      is_expected.to have_link(text: I18n.t('user.contents.title'),        href:contents_path(user.nickname))
    end

  end

end
