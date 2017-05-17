require 'uri'
require 'rack'

module GrapeSlack
  module UserHelper

    # Capybara-webkit使用
    # [参考] http://www.markcampbell.me/2016/04/18/decoding-the-ruby-on-rails-signed-session-cookie.html
    # [参考] http://qiita.com/h5y1m141@github/items/b96c9add83751b2417e9

    def current_user
      @current_user ||= User.find_by(id:session[:user_id]) if session[:user_id]
    end

    def session
      set_cookie
      {:user_id => page.driver.browser.rack_mock_session.cookie_jar['_user_id_session']}
    end

    def set_cookie
      page.driver.browser.clear_cookies
      page.driver.browser.set_cookie("_user_id_session=#{User.first.id}; expires=#{Time.now.since(7.days).strftime("%a, %d %b %Y %H:%M:%S GMT")};")
    end

  end
end

RSpec.configure do |config|
  config.include GrapeSlack::UserHelper, :type => :feature
  config.include GrapeSlack::UserHelper, :type => :request
end