require 'rails_helper'

#TODO: まだ実装できていない
describe 'Contentsページ' do

  describe '投稿を削除する' do

    before do
      set_omniauth
      visit user_slack_omniauth_authorize_path
      click_link I18n.t('user.summaries.title')
      click_link I18n.t('user.summaries.tables.create')
      fill_in 'summary_title',  with: 'Test Title'
      click_button I18n.t('helpers.submit.create')
      click_link I18n.t('user.contents.title')
      click_link I18n.t('commons.delete')
    end

    specify "#{I18n.t('user.contents.title')}ページにリダイレクトする" do
      expect(current_path).to eq contents_path
    end

    specify 'フラッシュメッセージが表示される' do
      expect(page).to have_content(I18n.t('user.contents.messages.destroy'))
    end

  end

end

