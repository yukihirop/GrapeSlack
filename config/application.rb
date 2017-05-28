require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GrapeSlack
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.text_framework = 'rspec'
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    # デフォルトを日本語にする
    config.i18n.default_locale = :ja

    # オートロードパスの追加
    config.autoload_paths << Rails.root.join('app/models/grape_slack')
    config.autoload_paths << Rails.root.join('app/models/grape_slack/api')

  end
end
