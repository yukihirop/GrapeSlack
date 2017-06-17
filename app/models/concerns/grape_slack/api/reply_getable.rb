require 'slack'
module GrapeSlack
  module Api
    module ReplyGetable

      refine String do
        def to_unixtime
          #p123456789 => 123.456789
          delete('p').insert(-7,'.')
        end
      end

      def reply(slack_url, member)
        @slack_url = slack_url
        @member = member
        user_id2name Slack.client.channels_replies(channel: channel, thread_ts: thread_ts)
      end


      private
      def user_id2name(reply)
        #TODO: 認証ができなかった時の処理をかく
        reply_message = Marshal.load(Marshal.dump(reply['messages'].first))
        reply_message.merge!({
                                 'id'   => reply_message['user'],
                                 'text' => reply_message['text'].gsub(/<@(.+?)>/){"@#{@member['name'][$1]}"}
                             })
      end

      def channel
        @slack_url.split('/')[4]
      end

      using GrapeSlack::Api::ReplyGetable
      def thread_ts
        @slack_url.split('/')[5].to_unixtime
      end
    end
  end
end