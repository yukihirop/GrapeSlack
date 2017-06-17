require 'slack'

module GrapeSlack
  module Api
    module ChannelGetable

      def channel_list
        @list = {}
        channels_list ||= Slack.client.channels_list
        @list = channels_list['channels'].map{|channel| [channel['name'], channel['id']]}.to_h
      end

      def channel_list_from_redis
        execute_channel_list_from_redis
        (@list_from_redis.present?) ? @list_from_redis : nil
      end

      private
      def execute_channel_list_from_redis
        @list_from_redis = {}
        begin
          list_from_redis_with_timeout
        rescue Timeout::Error
          list_from_redis_with_rescue
        end
        @list_from_redis
      end

      def list_from_redis_with_timeout
        Timeout.timeout(Settings.redis[:hgetall][:timeout]) do
          while @list_from_redis.blank?
            @list_from_redis = Redis.current.hgetall('slack_channel:name')
          end
        end
      end

      def list_from_redis_with_rescue
        if kind_of?(ApplicationController)
          @list_from_redis = nil
          flash[:danger_channel_timeout] = 'Slackチャンネル取得タイムアウトエラー'
        else
          #TODO: loggerで次回プルリクの際警告を出す。
        end
      end
    end
  end
end