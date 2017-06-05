require 'slack'

Slack.configure do |config|
  config.token = ENV['TOKEN']
end