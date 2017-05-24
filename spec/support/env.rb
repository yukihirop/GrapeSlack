# OmniAuthをテストモードにセット
OmniAuth.config.test_mode = true

# Capybara-Webkitドライバー (デフォルト)
Capybara.default_driver = :rack_test
Capybara.javascript_driver = :webkit
# 非表示要素がfindやhave_selectorなどにヒットしないようにする
Capybara.ignore_hidden_elements = true
# 最大待ち時間を5秒にする
Capybara.default_max_wait_time = 5

# Capybara::InfiniteRedirectError: redirected more than 5 times, check for infinite redirects. 対策
# デフォルトのドライバーのfollow_redirectsをfalseに
Capybara.register_driver :rack_test_non_redirect do |app|
  Capybara::RackTest::Driver.new(app, :follow_redirects => false)
end

#よくわからないurlを許可
Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
  config.ignore_ssl_errors
end
