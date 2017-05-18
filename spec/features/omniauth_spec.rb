require 'rails_helper'

feature 'OmniAuth interface'  do

  after { OmniAuth.config.mock_auth[:slack] = nil}

  context '新規ユーザーorSlack非登録ユーザー' do

    context '正常系' do

      context '認証成功' do

        before do
          visit root_path
          set_omniauth
          visit new_user_session_path
        end

        specify '自分のユーザー情報ページに遷移する' do
          expect(current_path).to eq(user_info_path)
        end

        specify 'ユーザー情報を取得出来る' do
          expect(page).to have_content('Mock User')
        end

      end

      # Capybaraのドライバーをrack_test(Capybaraデフォルトのドライバ)から
      # Infinite Redirectを無視するドライバー(rack_test_non_redirect)へ変更
      # omniauth-slack(もしくはSlack?)の仕様で認証できないとリダイレクトループするのを回避
      context '認証失敗', :rack_test_non_redirect => true do

        before do
          visit root_path
          set_invalid_omniauth
          visit new_user_session_path
        end

        specify 'ルートページに遷移する' do
          expect(current_path).to eq(new_user_session_path)
        end

      end

    end

  end

end