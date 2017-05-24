require 'rails_helper'

describe 'Summariesページ', :js => true do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
    visit summaries_path
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    before do
      click_link  I18n.t('user.summaries.tables.create_title')
      fill_in 'summary_title',  with: 'Test Title'
      click_button I18n.t('helpers.submit.create')
    end

    specify '作成したまとめがテーブルに挿入される' do
      expect(page).to have_css('td', text: 'Test Title')
    end

    specify "#{I18n.t('commons.add')}リンクが表示される" do
      #findに変更しないと@summary.saveされる前に検証してしまう(以下、同じ)
      expect(find('.table')).to have_link(text: I18n.t('commons.add'), href: new_summary_content_path(Summary.last.id))
    end

    specify "#{I18n.t('commons.delete')}リンクが表示される" do
      expect(find('.table')).to have_link(text: I18n.t('commons.delete'), href:summary_path(Summary.last.id))
    end

    #TODO: まだ実装できていない
    context 'まとめを閲覧する' do

      before do
        within('.table') do
          visit summary_path(Summary.last.id)
        end
      end

      specify 'タイトルの表示確認' do
        expect(find('.col-md-9')).to have_css('h3', text: "#{Summary.last.title}")
      end

      specify 'プロフィール画像の表示確認' do
        expect(find('.media-left')).to have_selector('img')
      end

      specify '投稿者の表示確認' do
        expect(find('.media-body')).to have_selector('h5')
      end

      specify '投稿内容の表示確認' do
        expect(find('.media-body')).to have_selector('p')
      end

      specify "#{I18n.t('commons.delete')}ボタンの表示確認" do
        expect(find('.media-right')).to have_selector('a')
      end

      specify "#{I18n.t('user.summaries.forms.back')}リンクの表示確認" do
        expect(find('.actions')).to have_link(text: "#{I18n.t('user.summaries.forms.back')}", href:summaries_path)
      end

    end

    context 'まとめを削除する' do

      let(:summary_id){ Summary.last.id }
      let(:content_id){ Summary.last.contents.last.id}

      before do
        within('.table') do
          visit summary_path(Summary.last.id)
        end
      end

      specify 'コンファームメッセージの表示確認' do
        expect(find('.media-right')).to have_link(text: "#{I18n.t('commons.delete')}", href:summary_content_path(summary_id, content_id))
        link = find_link I18n.t('commons.delete')
        expect(link['data-confirm']).to eq(I18n.t('commons.are_you_sure'))
      end

      context 'コンファームOKの場合' do

        before do
          within(find('.media-right')) do
            page.accept_confirm do
              click_link I18n.t('commons.delete')
            end
          end
        end

        specify 'まとめ一覧のページにリダイレクト' do
          expect(current_path).to eq(summary_path(summary_id))
        end

        specify 'Notificationメッセージの表示確認' do
          expect(page).to have_content (I18n.t('user.contents.messages.destroy'))
        end

        specify 'テーブルの行にTitleがTest Titleの行を持たないことを確認' do
          expect(find('h3')).not_to have_css('h3', text: 'Test Title')
        end

      end

    end

  end

end
