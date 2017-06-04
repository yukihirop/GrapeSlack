require 'slack'
require 'member'

module GrapeSlack
  module Api

    refine String do
      def to_unixtime
        delete('p').insert(-7,'.')
      end
    end

    class Reply

      attr_reader :reply

      def initialize (slack_url, member)
        @slack_url = slack_url
        @member = member
      end

      def reply
        user_id2name Slack.client.channels_replies(channel: channel, thread_ts: thread_ts)
      end

      def user_id2name reply
        reply_message = Marshal.load(Marshal.dump(reply['messages'].first))
        reply_message.merge!({
                                 'id'   => reply_message['user'],
                                 'text' => reply_message['text'].gsub(/<@(.+?)>/){"@#{@member['name'][$1]}"}
                             })
      end

      def channel
        @slack_url.split('/')[4]
      end

      using GrapeSlack::Api
      def thread_ts
        @slack_url.split('/')[5].to_unixtime
      end

    end
  end
end