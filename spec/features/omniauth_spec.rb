require 'rails_helper'

feature 'OmniAuth interface' do

  after { OmniAuth.config.mock_auth[:slack] = nil}

  context '新規ユーザーorSlack非登録ユーザー' do

    let(:submit) { 'Sign up by Slack' }

    context '正常系' do

      let(:provider) { 'slack' }

      context '認証成功' do

        before do
          visit root_path
          set_omniauth
          click_link(submit)
        end

        specify 'Users#showページに遷移する' do
          expect(current_path).to eq("/auth/#{provider}/callback")
        end

        specify 'ユーザー情報を取得出来る' do
          expect(page).to have_content('Mock User')
        end

      end

      context '認証失敗' do

        before do
          visit root_path
          set_invalid_omniauth
          click_link(submit)
        end

        specify 'Users#indexページに遷移する' do
          expect(current_path).to eq(root_path)
        end

      end

    end

  end

end