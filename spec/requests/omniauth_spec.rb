require 'rails_helper'

# [参考] http://kinjouj.github.io/2014/07/rails-omnioauth-facebook-login.html
RSpec.describe 'OmniAuth-Slack Authorization', :type => :request do

  context '新規登録ユーザーor非登録ユーザー' do

    let(:provider) { 'slack' }

    context '正常系' do

      context '認証成功' do

        before do
          set_omniauth
          visit user_slack_omniauth_authorize_path
        end

        subject do
          JSON.parse(current_user.to_json)
        end

        example 'ユーザー情報を取得できる' do
          expect(subject).to include ({
              'provider'  => 'slack',
              'uid'       => 'mock_uid_1234',
              'first_name'    => 'Mock first',
              'last_name'     => 'Mock last',
              'name'          => 'Mock User',
              'profile_img_url' => 'http://mock-image.png',
              'email'         => 'Mock@example.com'.downcase
          })
        end

      end

      # Capybaraのドライバーをrack_test(Capybaraデフォルトのドライバ)から
      # Infinite Redirectを無視するドライバー(rack_test_non_redirect)へ変更
      # omniauth-slack(もしくはSlack?)の仕様で認証できないとリダイレクトループするのを回避
      context '認証失敗', :rack_test_non_redirect => true do

        before do
          set_invalid_omniauth
          visit user_slack_omniauth_authorize_path
        end

        example 'ステータス 302が返る' do
          expect(page.status_code).to eq 302
        end

      end

    end

  end

end