require 'rails_helper'

describe 'Profileページ' do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    before do
      within(find('.col-md-3')) do
        click_link I18n.t('user.profile.title')
      end
    end

    specify 'テーブルのタイトルの確認' do
      expect(find('.col-md-9')).to have_css('h3', text: I18n.t('user.info'))
    end

    context 'テーブルヘッダ' do

      specify 'テーブルのヘッダ：1列目の確認' do
        expect(find('.table')).to have_css('thead', text: I18n.t('user.profile.tables.row_1'))
      end

      specify 'テーブルのヘッダ：２列目の確認' do
        expect(find('.table')).to have_css('thead', text: I18n.t('user.profile.tables.row_2'))
      end

    end

    context 'テーブル１列目' do

      specify '名前の確認' do
        expect(find('.table')).to have_css('tr', text: I18n.t('user.profile.tables.name'))
      end

      specify '姓の確認' do
        expect(find('.table')).to have_css('tr', text: I18n.t('user.profile.tables.last_name'))
      end

      specify '名の確認' do
        expect(find('.table')).to have_css('tr', text: I18n.t('user.profile.tables.first_name'))
      end

      specify 'メールアドレスの確認' do
        expect(find('.table')).to have_css('tr', text: I18n.t('user.profile.tables.email'))
      end

      specify 'パスワードの確認' do
        expect(find('.table')).to have_css('tr', text: I18n.t('user.profile.tables.password'))
      end

      specify 'プロフィール画像の確認' do
        expect(find('.table')).to have_css('tr', text: I18n.t('user.profile.tables.profile_img_url'))
      end

    end

  end

end
