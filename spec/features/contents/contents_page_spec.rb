require 'rails_helper'

describe 'Contentsページ', :js => true do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
    visit summaries_path
    click_link  I18n.t('user.summaries.tables.create_title')
    fill_in 'summary_title',  with: 'Test Title'
    click_button I18n.t('helpers.submit.create')
    visit contents_path
  end

  #TODO: まだ実装出来ていない
  context '正常系(ボタンクリックなどによる外観の変化)' do

    specify "ページタイトル:#{I18n.t('user.contents.title')}が表示される" do
      expect(find('.col-md-9')).to have_css('h3', text: I18n.t('user.contents.title'))
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
      expect(find('.actions')).to have_link(text: "#{I18n.t('user.summaries.forms.back')}")
    end


    #TODO: まだ実装できていない
    context '投稿を削除する' do

      let(:summary_id){ Summary.last.id }
      let(:content_id){ Summary.last.contents.last.id}

      specify 'コンファームメッセージの表示確認' do
        expect(find('.media-right')).to have_link(text: "#{I18n.t('commons.delete')}")
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
          expect(current_path).to eq(contents_path)
        end

        specify 'Notificationメッセージの表示確認' do
          expect(find('.col-md-9')).to have_content (I18n.t('user.contents.messages.destroy'))
        end

        specify 'テーブルの行にTitleがTest Titleの行を持たないことを確認' do
          expect(find('.col-md-9')).not_to have_css('h3', text: 'Test Title')
        end

      end

    end

  end

end
