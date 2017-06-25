require 'rails_helper'

describe 'Navbar' do
  let (:user) { User.last }

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
  end

  subject { page }

  context '表示確認' do

    it 'タイトル・プロフィールリンク・ログアウトリンクの確認' do
      is_expected.to have_content('GrapeSlack')
      is_expected.to have_link(text: "#{user.name}",          href:user_profile_path(user.nickname))
      is_expected.to have_link(text: I18n.t('commons.logout'),href:destroy_user_session_path)
    end

  end

end
