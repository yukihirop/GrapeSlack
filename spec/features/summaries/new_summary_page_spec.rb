require 'rails_helper'

describe 'New Summaryページ' do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
    visit summaries_path
    click_link I18n.t('user.summaries.tables.create_title')
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    before do
      #idで指定
      fill_in 'summary_title', with: 'Test Title'
      click_button I18n.t('helpers.submit.create')
    end

    specify '新しいSummaryを作成できたらSummariesページに遷移する' do
      within(find('.col-md-9')) do
        expect(current_path).to eq(summaries_path)
      end
    end

    specify '遷移先にメッセージが表示される' do
      expect(page).to have_content(I18n.t('user.summaries.messages.create'))
    end

    specify '遷移先のタイトルが作成したものが表示されている' do
      expect(find('.table')).to have_css('td', text: 'Test Title')
    end

  end

end
