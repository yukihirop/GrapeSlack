require 'rails_helper'

describe 'Profileページ' do

  before do
    set_omniauth
    visit user_slack_omniauth_authorize_path
  end

  context '正常系(ボタンクリックなどによる外観の変化)' do

    before do
      click_link I18n.t('user.profile.title')
    end

    specify 'テーブルのタイトルの確認' do
      expect(page).to have_content(I18n.t('user.info'))
    end

    context 'テーブルヘッダ' do

      specify 'テーブルのヘッダ：項目の確認' do
        expect(page).to have_content(I18n.t('user.profile.tables.rows.items'))
      end

      specify 'テーブルのヘッダ：内容の確認' do
        expect(page).to have_content(I18n.t('user.profile.tables.rows.contents'))
      end

    end

    context 'テーブル列:項目' do

      specify '名前の確認' do
        expect(page).to have_content(I18n.t('user.profile.tables.name'))
      end

      specify '姓の確認' do
        expect(page).to have_content(I18n.t('user.profile.tables.last_name'))
      end

      specify '名の確認' do
        expect(page).to have_content(I18n.t('user.profile.tables.first_name'))
      end

      specify 'メールアドレスの確認' do
        expect(page).to have_content(I18n.t('user.profile.tables.email'))
      end

      specify 'パスワードの確認' do
        expect(page).to have_content(I18n.t('user.profile.tables.password'))
      end

      specify 'プロフィール画像の確認' do
        expect(page).to have_content(I18n.t('user.profile.tables.profile_img_url'))
      end

    end

  end

end
