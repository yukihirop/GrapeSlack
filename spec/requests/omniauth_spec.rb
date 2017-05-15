require 'rails_helper'

# [参考] http://kinjouj.github.io/2014/07/rails-omnioauth-facebook-login.html
RSpec.describe 'OmniAuth-Slack Authorization', :type => :request do

  context '新規登録ユーザーor非登録ユーザー' do

    let(:provider) { 'slack' }

    context '正常系' do

      context '認証成功' do

        before do
          set_omniauth
          get "/auth/#{provider}/callback"
        end

        example 'ユーザー情報を取得できる' do
          expect(request.env['omniauth.auth']).to eq ({
              "provider"  => "slack",
              "uid"       => "mock_uid_1234",
              "info"      => {
                  "name"          => "Mock User",
                  "description"   => "Mock description"
              },
              "credentials" => {
                  "token"   => "mock_credentials_token",
                  "expires" => false
              },
              "extra" => {
                  "raw_info" => {
                      "ok"    => "Mock User",
                      "team"  => "Mock Team"
                  }
              }
          })
        end

      end

      # Capybaraでテスト
      context '認証失敗' do

        before do
          page.driver.options[:follow_redirects] = false
          set_invalid_omniauth
          visit "/auth/#{provider}/callback"
        end

        example 'ステータス 302が返る' do
          expect(page.status_code).to eq 302
        end

        example 'ルートにリダイレクト' do
          expect(page.response_headers['Location']).to match(auth_failure_path)
        end

      end

    end

  end

end