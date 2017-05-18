require 'rails_helper'

describe 'Summariesページ', :js => true do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
    visit summaries_path
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    before do
      click_link 'まとめ作成'
      fill_in 'Title',  with: 'Test Title'
      click_button '登録する'
      click_link '戻る'
    end

    specify '作成したまとめがテーブルに挿入される' do
      expect(page).to have_css('td', text: 'Test Title')
    end

    specify '表示リンクが表示される' do
      expect(page).to have_link(text: '表示', href:summary_path(Summary.last.id))
    end

    specify '削除リンクが表示される' do
      expect(page).to have_link(text: '削除', href:summary_path(Summary.last.id))
    end

    context 'まとめを閲覧する' do

      before do
        click_link '表示'
      end

      specify 'Titleのパラグラフの表示確認' do
        expect(page).to have_css('strong', text: 'Title:')
        expect(page).to have_css('p', text: 'Test Title')
      end

      specify 'Userのパラグラフの表示確認' do
        expect(page).to have_css('strong', text: 'User:')
      end

      specify '戻るリンクの表示確認' do
        expect(page).to have_link(text: '戻る', href:summaries_path)
      end

    end

    context 'まとめを削除する' do

      specify 'コンファームメッセージの表示確認' do
        expect(page).to have_link(text: '削除', href:summary_path(Summary.last.id))
        link = find_link '削除'
        expect(link['data-confirm']).to eq('本当に削除しますか?')
      end

      context 'コンファームOKの場合' do

        before do
          page.accept_confirm  do
            click_link '削除'
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
          page.dismiss_confirm  do
            click_link '削除'
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
