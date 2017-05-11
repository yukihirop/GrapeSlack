require 'rails_helper'

describe 'Summariesページ', :js => true do

  before do
    visit summaries_path
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    let!(:slack_user){ create(:slack_user) }

    before do
      click_link 'New Summary'
      fill_in 'Title',  with: 'Test Title'
      fill_in 'Slack',  with: "#{slack_user.id}"
      click_button 'Create Summary'
      click_link 'Back'
    end

    specify '作成したまとめがテーブルに挿入される' do
      expect(page).to have_css('td', text: 'Test Title')
    end

    specify 'Showリンクが表示される' do
      expect(page).to have_link(text: 'Show', href:summary_path(Summary.last.id))
    end

    specify 'Destroyリンクが表示される' do
      expect(page).to have_link(text: 'Destroy', href:summary_path(Summary.last.id))
    end

    context 'まとめを閲覧する' do

      before do
        click_link 'Show'
      end

      specify 'Titleのパラグラフの表示確認' do
        expect(page).to have_css('strong', text: 'Title:')
        expect(page).to have_css('p', text: 'Test Title')
      end

      specify 'Slackのパラグラフの表示確認' do
        expect(page).to have_css('strong', text: 'Slack:')
      end

      specify 'Backリンクの表示確認' do
        expect(page).to have_link(text: 'Back', href:summaries_path)
      end

    end

    context 'まとめを削除する' do

      specify 'コンファームメッセージの表示確認' do
        expect(page).to have_link(text: 'Destroy', href:summary_path(Summary.last.id))
        link = find_link 'Destroy'
        expect(link['data-confirm']).to eq('Are you sure?')
      end

      context 'コンファームOKの場合' do

        before do
          page.accept_confirm 'Are you sure' do
            click_link 'Destroy'
          end
          expect(current_path).to eq(summaries_path)
        end

        specify 'Notificationメッセージの表示確認' do
          within 'p' do
            expect(page).to have_content 'Summary was successfully destroyed.'
          end
        end

        specify 'テーブルの行にTitleがTest Titleの行を持たないことを確認' do
          expect(page).not_to have_css('td', text: 'Test Title')
        end

      end

      context 'コンファームCancelの場合' do

        before do
          page.dismiss_confirm 'Are you sure' do
            click_link 'Destroy'
          end
          expect(current_path).to eq(summaries_path)
        end

        specify '作成したまとめのタイトル(Test Title)が表示されていることを確認' do
          expect(page).to have_css('td', text: 'Test Title')
        end

      end

    end

  end

end