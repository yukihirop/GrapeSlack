require 'rails_helper'

describe 'Profileページ' do

  let(:user) { User.last }

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
  end

  subject { page }

  context '表示確認' do

    before do
      click_link I18n.t('user.profile.title')
    end

    it 'テーブルのヘッダの確認' do
      is_expected.to have_content(I18n.t('user.info'))
      is_expected.to have_content(I18n.t('user.profile.tables.rows.items'))
      is_expected.to have_content(I18n.t('user.profile.tables.rows.contents'))
    end

    it '名前の確認' do
      is_expected.to have_content(user.name)
      is_expected.to have_content(user.last_name)
      is_expected.to have_content(user.first_name)
      is_expected.to have_content(user.email)
    end

  end

end
