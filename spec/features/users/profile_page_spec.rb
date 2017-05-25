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

      specify "テーブルのヘッダ：#{I18n.t('user.profile.tables.rows.items')}の確認" do
        expect(page).to have_content(I18n.t('user.profile.tables.rows.items'))
      end

      specify "テーブルのヘッダ：#{I18n.t('user.profile.tables.rows.contents')}の確認" do
        expect(page).to have_content(I18n.t('user.profile.tables.rows.contents'))
      end

    end

    context "テーブル列:#{I18n.t('user.profile.tables.rows.items')}" do

      specify "#{I18n.t('user.profile.tables.name')}の確認" do
        expect(page).to have_content(I18n.t('user.profile.tables.name'))
      end

      specify "#{I18n.t('user.profile.tables.last_name')}の確認" do
        expect(page).to have_content(I18n.t('user.profile.tables.last_name'))
      end

      specify "#{I18n.t('user.profile.tables.first_name')}の確認" do
        expect(page).to have_content(I18n.t('user.profile.tables.first_name'))
      end

      specify "#{I18n.t('user.profile.tables.email')}の確認" do
        expect(page).to have_content(I18n.t('user.profile.tables.email'))
      end

      specify "#{I18n.t('user.profile.tables.password')}の確認" do
        expect(page).to have_content(I18n.t('user.profile.tables.password'))
      end

      specify "#{I18n.t('user.profile.tables.profile_img_url')}の確認" do
        expect(page).to have_content(I18n.t('user.profile.tables.profile_img_url'))
      end

    end

  end

end
