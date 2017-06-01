require 'slack'

module GrapeSlack
  module Api
    class Channel

      attr_reader :list, :list_from_redis

      def initialize
        Slack.configure do |config|
          config.token = ENV['TOKEN']
        end
      end

      def list
        @list ||= {}
        channels_list ||= Slack.client.channels_list
        @list['name'] = channels_list['channels'].map{|channel| [channel['name'], channel['id']]}.to_h
        @list
      end

      def list_from_redis
        @list_from_redis ||= {}
        @list_from_redis['name'] = Redis.current.hgetall('slack_channel:name')
        @list_from_redis
      end


    end
  end
end