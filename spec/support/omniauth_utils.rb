# [参考] http://qiita.com/mnishiguchi/items/3d6a4ec36c2237a11660
def set_omniauth
  OmniAuth.config.mock_auth[:slack] =
      OmniAuth::AuthHash.new(
          {
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
          }
      )
end

def set_invalid_omniauth
  OmniAuth.config.mock_auth[:slack] = :invalid_credentials
end