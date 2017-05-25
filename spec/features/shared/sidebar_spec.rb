require 'rails_helper'

describe 'Sidebar' do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    # [参考] http://qiita.com/maangie/items/4522fb16a0fd78fd150e
    specify 'プロフィールリンクの確認' do
      expect(page).to have_link(text: I18n.t('user.profile.title'),href:user_profile_path)
    end

    specify 'まとめ一覧リンクの確認' do
      expect(page).to have_link(text: I18n.t('user.summaries.title'),href:summaries_path)
    end

    specify '投稿一覧リンクの確認' do
      expect(page).to have_link(text: I18n.t('user.contents.title'),href:contents_path)
    end

  end

end
