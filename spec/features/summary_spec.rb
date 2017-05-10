require 'rails_helper'

describe 'Summariesページ', :js => true do

  before do
    visit '/summaries'
  end

  context '外観' do

    specify 'タイトルの表示の確認' do
      expect(page).to have_css('h1', text: 'Summaries')
    end

    specify 'New Summaryリンクの表示の確認' do
      expect(page).to have_link(text: 'New Summary', href: '/summaries/new')
    end
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
      expect(page).to have_link(text: 'Show', href:"/summaries/#{Summary.last.id}")
    end

    specify 'Destroyリンクが表示される' do
      expect(page).to have_link(text: 'Destroy', href: "/summaries/#{Summary.last.id}")
    end

    context 'Showリンクをクリックする' do

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

      specify 'Editリンクの表示確認' do
        expect(page).to have_link(text: 'Edit', href:"/summaries/#{Summary.last.id}/edit")
      end

      specify 'Backリンクの表示確認' do
        expect(page).to have_link(text: 'Back', href:"/summaries")
      end

    end

    context 'Destroyリンクをクリックする' do

      specify 'コンファームメッセージの表示確認' do
        expect(page).to have_link(text: 'Destroy', href:"/summaries/#{Summary.last.id}")
        link = find_link 'Destroy'
        expect(link['data-confirm']).to eq('Are you sure?')
      end

      context 'コンファームOKの場合' do

        before do
          page.accept_confirm 'Are you sure' do
            click_link 'Destroy'
          end
          expect(current_path).to eq("/summaries")
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
          expect(current_path).to eq("/summaries")
        end

        specify 'テーブルの行にTitleがTest Titleの行を持つことを確認' do
          expect(page).to have_css('td', text: 'Test Title')
        end

      end


    end

  end

end

describe 'New Summaryページ' do

  before do
    visit '/summaries'
    click_link 'New Summary'
  end

  context '外観' do

    specify 'タイトルの表示の確認' do
      expect(page).to have_css('h1', text: 'New Summary')
    end

    specify 'Titleテキストボックスの確認' do
      expect(page).to have_css('label', text: 'Title')
      expect(page).to have_xpath("//input[@id='summary_title']")
    end

    specify 'Slackテキストボックスの確認' do
      expect(page).to have_css('label', text: 'Slack')
      expect(page).to have_xpath("//input[@id='summary_slack_id']")
    end

    specify 'Create Summaryボタンの確認' do
      expect(page).to have_xpath("//input[@value='Create Summary']")
    end

    specify 'Backリンクの確認' do
      expect(page).to have_link(text: 'Back', href: '/summaries')
    end

  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    let!(:slack_user){ create(:slack_user) }

    before do
      fill_in 'Title', with: 'Test Title'
      fill_in 'Slack', with: "#{slack_user.id}"
      click_button 'Create Summary'
    end


    specify '新しいSummaryを作成できたらSummariesページに遷移する' do
      expect(current_path).to eq("/summaries/#{Summary.last.id}")
    end

    specify '遷移先にメッセージが表示される' do
      expect(page).to have_css('p', text: 'Summary was successfully created.')
    end

    specify '遷移先のタイトルが作成したものが表示されている' do
      expect(page).to have_css('p', text: 'Test Title')
    end

    specify '遷移先にEditリンクがある' do
      expect(page).to have_link(text: 'Edit', href: "/summaries/#{Summary.last.id}/edit")
    end

    specify '遷移先にBackリンクがある' do
      expect(page).to have_link(text: 'Back', href: "/summaries")
    end

  end

  context '異常系(ボタンクリックなどによる外観の変化)' do
    context '存在しないslack.idを打った場合' do

      let!(:slack_user){ create(:slack_user) }

      before do
        fill_in 'Title', with: 'Test Title'
        fill_in 'Slack', with: '-1'
        click_button 'Create Summary'
      end

      specify 'エラーメッセージが表示される(タイトル)' do
        expect(page).to have_css('h2', text: '1 error prohibited this summary from being saved:')
      end

      specify 'エラーメッセージが表示される(内容)' do
        expect(page).to have_css('li', text:'Slack must exist')
      end

      specify '新しいSummaryを作成できたらSummariesページに遷移しない' do
        expect(current_path).not_to eq("/summaries/-1")
        expect(current_path).to eq("/summaries")
      end
    end
  end
end
