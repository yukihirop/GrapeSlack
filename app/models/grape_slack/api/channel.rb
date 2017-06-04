require 'slack'

module GrapeSlack
  module Api
    class Channel

      attr_reader :list, :list_from_redis

      def list
        @list ||= {}
        channels_list ||= Slack.client.channels_list
        @list = channels_list['channels'].map{|channel| [channel['name'], channel['id']]}.to_h
      end

      def list_from_redis
        @list_from_redis ||= {}
        @list_from_redis = Redis.current.hgetall('slack_channel:name')
      end


    end
  end
end