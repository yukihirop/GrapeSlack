# [参考] http://qiita.com/mnishiguchi/items/3d6a4ec36c2237a11660
def set_omniauth
  OmniAuth.config.mock_auth[:slack] =
      OmniAuth::AuthHash.new(
          {
              'provider'  => 'slack',
              'uid'       => 'mock_uid_1234',
              'info'      => {
                  'first_name'    => 'Mock first',
                  'last_name'     => 'Mock last',
                  'name'          => 'Mock User',
                  'description'   => 'Mock description',
                  'image_24'      => 'http://mock-image.png',
                  'email'         => 'Mock@example.com'
              }
          }
      )
end

def set_invalid_omniauth
  OmniAuth.config.mock_auth[:slack] = :invalid_credentials
end