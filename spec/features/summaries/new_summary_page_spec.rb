require 'rails_helper'

describe 'New Summaryページ' do

  before do
    visit summaries_path
    click_link 'New Summary'
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    let!(:user){ create(:user) }

    before do
      fill_in 'Title', with: 'Test Title'
      fill_in 'User', with: "#{user.id}"
      click_button 'Create Summary'
    end


    specify '新しいSummaryを作成できたらSummariesページに遷移する' do
      expect(current_path).to eq(summary_path(Summary.last.id))
    end

    specify '遷移先にメッセージが表示される' do
      expect(page).to have_css('p', text: 'Summary was successfully created.')
    end

    specify '遷移先のタイトルが作成したものが表示されている' do
      expect(page).to have_css('p', text: 'Test Title')
    end

    specify '遷移先にBackリンクがある' do
      expect(page).to have_link(text: 'Back', href:summaries_path)
    end

  end

  context '異常系(ボタンクリックなどによる外観の変化)' do

    context '存在しないslack.idを打った場合' do

      let!(:user){ create(:user) }

      before do
        fill_in 'Title', with: 'Test Title'
        fill_in 'User', with: '-1'
        click_button 'Create Summary'
      end

      specify 'エラーメッセージが表示される(タイトル)' do
        expect(page).to have_css('h2', text: '1 error prohibited this summary from being saved:')
      end

      specify 'エラーメッセージが表示される(内容)' do
        expect(page).to have_css('li', text:'User must exist')
      end

      specify '新しいSummaryを作成できなかったのでSummariesページに遷移しない' do
        expect(current_path).to eq(summaries_path)
      end

    end

  end

end
