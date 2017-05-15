require 'rails_helper'

feature 'OmniAuth interface' do

  before { OmniAuth.config.mock_auth[:slack] = nil}

  context '新規ユーザーorSlack非登録ユーザー' do

    let(:submit) { 'Sign up by Slack' }

    context '正常系' do

      before do
        visit root_path
        set_omniauth
        click_link(submit)
      end

      context '認証成功' do

        specify 'Users#showページに遷移する' do
          expect(page).to have_css('h1', text:'Users#show')
        end

      end

    end

    context '異常系' do

      before do
        visit root_path
        set_invalid_omniauth
        click_link(submit)
      end

      context '認証失敗'

      specify 'Users#indexページに遷移する' do
        expect(page).to have_css('h1', text: 'Users#index')
      end

    end

  end

end