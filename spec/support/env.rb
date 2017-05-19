# OmniAuthをテストモードにセット
OmniAuth.config.test_mode = true

# Capybara-Webkitドライバー (デフォルト)
Capybara.default_driver = :rack_test
Capybara.javascript_driver = :webkit

# Capybara::InfiniteRedirectError: redirected more than 5 times, check for infinite redirects. 対策
# デフォルトのドライバーのfollow_redirectsをfalseに
Capybara.register_driver :rack_test_non_redirect do |app|
  Capybara::RackTest::Driver.new(app, :follow_redirects => false)
end
