# [参考] http://qiita.com/mnishiguchi/items/3d6a4ec36c2237a11660
def set_omniauth
  OmniAuth.config.mock_auth[:slack] =
      OmniAuth::AuthHash.new(
          {
              'provider'  => 'slack',
              'uid'       => 'mock_uid_1234',
              'info'      => {
                  'first_name'    => 'Mock_first',
                  'last_name'     => 'Mock_last',
                  'name'          => 'Mock User',
                  'nickname'      => 'Mock_nickname',
                  'email'         => 'Mock@example.com'
              },
              'extra' => {
                'user_info' => {
                  'user' => {
                    'profile' => {
                      'image_192' => 'http://mock-image.png'
                    }
                  }
                }
              }
          }
      )
end

def set_invalid_omniauth
  OmniAuth.config.mock_auth[:slack] = :invalid_credentials
end
