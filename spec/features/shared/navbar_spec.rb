require 'rails_helper'

describe 'Navbar' do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
  end

  let (:user_name) { User.last.name }

  context '正常系(ボタンクリックなどによる外観の変化)' do

    specify 'GrapeSlackの確認' do
      expect(find('.navbar-brand')).to have_content('GrapeSlack')
    end

    specify 'ユーザーリンクの確認' do
      expect(find('.navbar-right').find_all('li')[0]).to have_link(text: "#{user_name}",href:user_profile_path)
    end

    specify "#{I18n.t('commons.logout')}リンクの確認" do
      expect(find('.navbar-right').find_all('li')[1]).to have_link(text: I18n.t('commons.logout'),href:destroy_user_session_path)
    end

  end

end
