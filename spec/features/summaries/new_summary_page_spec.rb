require 'rails_helper'

describe 'New Summaryページ' do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
    visit summaries_path
    click_link 'まとめ作成'
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    before do
      fill_in 'Title', with: 'Test Title'
      click_button '登録する'
    end


    specify '新しいSummaryを作成できたらSummariesページに遷移する' do
      expect(current_path).to eq(summary_path(Summary.last.id))
    end

    specify '遷移先にメッセージが表示される' do
      expect(page).to have_content('Summary was successfully created.')
    end

    specify '遷移先のタイトルが作成したものが表示されている' do
      expect(page).to have_css('p', text: 'Test Title')
    end

    specify '遷移先にBackリンクがある' do
      expect(page).to have_link(text: '戻る', href:summaries_path)
    end

  end

end
