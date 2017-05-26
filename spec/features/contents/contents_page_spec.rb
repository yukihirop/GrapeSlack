require 'rails_helper'

describe 'Contentsページ' do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
    click_link I18n.t('user.summaries.title')
    click_link I18n.t('user.summaries.tables.create')
    fill_in 'summary_title',  with: 'Test Title'
    click_button I18n.t('helpers.submit.create')
    click_link I18n.t('user.contents.title')
  end

  #TODO: まだ実装出来ていない
  context '正常系(ボタンクリックなどによる外観の変化)' do

    specify "ページタイトル:#{I18n.t('user.contents.title')}が表示される" do
      expect(page).to have_content(I18n.t('user.contents.title'))
    end

    specify 'プロフィール画像の表示確認' do
      expect(page).to have_selector('img')
    end

    specify '投稿者の表示確認' do
      expect(page).to have_selector('h5')
    end

    specify '投稿内容の表示確認' do
      expect(page).to have_selector('p')
    end

    specify '削除リンクの表示確認' do
      expect(page).to have_selector('a')
    end

    specify '戻るリンクの表示確認' do
      expect(page).to have_link(text: "#{I18n.t('user.summaries.forms.back')}")
    end

  end

end
