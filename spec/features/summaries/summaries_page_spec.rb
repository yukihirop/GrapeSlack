require 'rails_helper'

describe 'Summariesページ' do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
    click_link I18n.t('user.summaries.title')
    click_link I18n.t('user.summaries.tables.create')
    fill_in 'summary_title',  with: 'Test Title'
    click_button I18n.t('helpers.submit.create')
  end

  context 'まとめを作成' do

    let(:summary_id) { Summary.last.id }

    specify '作成したまとめがテーブルに挿入される' do
      expect(page).to have_content('Test Title')
    end

    specify "#{I18n.t('commons.add')}リンクが表示される" do
      #findに変更しないと@summary.saveされる前に検証してしまう(以下、同じ)
      expect(page).to have_link(text: I18n.t('commons.add'), href: new_summary_content_path(summary_id))
    end

    specify "#{I18n.t('commons.delete')}リンクが表示される" do
      expect(page).to have_link(text: I18n.t('commons.delete'), href:summary_path(summary_id))
    end

  end

  #TODO: まだ実装できていない
  context 'まとめを閲覧する' do

    before do
      click_link 'Test Title'
    end

    let(:summary_title){ Summary.last.title }

    specify 'タイトルの表示確認' do
      expect(page).to have_content(summary_title)
    end

    # TODO: 後で内容を検証するテストにする
    specify 'プロフィール画像の表示確認' do
      expect(page).to have_selector('img')
    end

    specify '投稿者の表示確認' do
      expect(page).to have_selector('h5')
    end

    specify '投稿内容の表示確認' do
      expect(page).to have_selector('p')
    end

    specify "#{I18n.t('commons.delete')}ボタンの表示確認" do
      expect(page).to have_selector('a')
    end

    specify "#{I18n.t('user.summaries.forms.back')}リンクの表示確認" do
      expect(page).to have_link(text: "#{I18n.t('user.summaries.forms.back')}", href:summaries_path)
    end

  end

end

