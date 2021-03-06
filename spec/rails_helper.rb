# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'shoulda/matchers'
require 'mock_redis'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  #facotrygirl
  config.include FactoryGirl::Syntax::Methods

  config.before(:all) do
    FactoryGirl.reload
  end

  #databaserewinder
  #MySQL + use_transactional_tests Specific Problems
  config.use_transactional_examples = false

  config.before(:suite) do
    DatabaseRewinder.clean_all
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end

  #Capybara
  config.include Capybara::DSL

  # spec/support/env.rbに記載
  # 各テスト毎に webkit_non_redirectのブーリアンを調べてドライバーを使い分ける
  # [参考] http://web-k.github.io/blog/2012/11/07/capybara-driver/
  config.before(:all, :rack_test_non_redirect => true) do
    Capybara.current_driver = :rack_test_non_redirect
  end

  config.after(:all, :rack_test_non_redirect => true) do
    Capybara.use_default_driver
  end

  # モックオブジェクトにnilが設定されることを許容するか？
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end

  # Deviseの設定
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature

  #ShouldaMatchersの設定
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :active_record
      with.library :active_model
      with.library :action_controller
      with.library :rails
    end
  end

  # ResqueとRedisをRspecで使う設定
  # REDIS_PID = "#{Rails.root}/tmp/pids/redis-test.pid".freeze
  # REDIS_CACHE_PATH = "#{Rails.root}/tmp/cache/".freeze
  #
  # config.before(:suite) do
  #   redis_options = {
  #     'daemonize'     => 'yes',
  #     'pidfile'       => REDIS_PID,
  #     'port'          => 9_736,
  #     'timeout'       => 300,
  #     'dbfilename'    => 'dump.rdb',
  #     'dir'           => REDIS_CACHE_PATH
  #   }.map { |k, v| "#{k} \"#{v}\"" }.join("\n")
  #   `echo '#{redis_options}' | redis-server -`
  #
  #   redis_config = YAML.load_file(Rails.root + 'config/redis.yml')[Rails.env]
  #   namespace = [Rails.application.class.parent_name, Rails.env].join ':'
  #   Resque.redis = Redis.new(redis_config)
  #   Resque.after_fork = proc { ActiveRecord::Base.establish_connection }
  #   Redis.current = Redis::Namespace.new(namespace, redis: Redis.new(redis_config))
  # end
  #
  # config.after(:suite) do
  #   `
  #     cat "#{REDIS_PID}" | xargs kill -QUIT
  #     rm -f "#{REDIS_CACHE_PATH}dump.rdb"
  #   `
  # end

  # redisをmockする
  config.before(:each) do
    redis_instance = MockRedis.new
    Redis.stub(:new).and_return(redis_instance)
    Redis.current = Redis.new
  end

  # 各 example で読み込まれ、 activejob.queue_adapter を ActiveJob::QueueAdapter::TestAdapter にセットする
  # perform_enqueued_jobs などのテストヘルパーが使えるようになる
  config.include ActiveJob::TestHelper
end



