require 'slack'
require 'uri'

# slack
Slack.configure do |config|
  config.token =  Thread.current[:request].session[:token]
end

module GrapeSlackString
  refine String do
    def to_unix
      delete('p').insert(-7,'.')
    end
  end
end

# classにすると uninitialized constant GrapeSlack::Content::APi
# になって回避できなかったのでmodelにした。
module GrapeSlack
  module Content
    module Api

      USER_OPTIONS = %W[name first_name last_name image_48]

      def start
        @results = {}
      end

      def end
        @results
      end

      def client=(token)
        @token = token
      end

      def client
        @token
      end

      def tURLs=(urls)
        @urls = urls
      end

      def tURLs
        @urls
      end

      def preparate(attributes = nil)
        attributes.each do |k,v|
          send("#{k.to_s}=", v) if respond_to?("#{k.to_s}=")
        end if attributes
        yield self if block_given?
      end

      using GrapeSlackString
      def replies
        replies = []
        @results.delete('replies') unless @results.empty?
        hchannelThreadts.each do |thread_ts, channel|
          replies << client.channels_replies(channel: channel, thread_ts: thread_ts.to_unix)
        end
        @replies = replies.map{|rep| rep['messages']}.compact.flatten
        @replies.each_with_index do |el, i|
          el.delete('type')
          el['id'] = el['user']
          el.store('user', users['name'][el['user']])
          el['text'].gsub!(/<@(.+?)>/){"@#{users['name'][$1]}"}
        end
        @results['replies'] = @replies
      end

      # 非同期処理にしたい
      # TODO:
      def users
        @users ||= {}
        @results.delete('users') unless @results.empty?
        USER_OPTIONS.each do |opt|
          if opt == 'name'
            @users[opt] = client.users_list['members'].map{ |m| [ m['id'], m[opt] ] }.to_h
          else
            @users[opt] = client.users_list['members'].map{ |m| [ m['id'], m['profile'][opt] ] }.to_h
          end
        end if @users.empty?
        @results['users'] = @users
      end


      private

      def aURLs
        @aURLs = URI.extract(tURLs, ['https']).map{|tURL| tURL.split(',')}
        @aURLs.flatten.grep(/https:\/\/aiming.slack.com\/archives/).uniq
      end

      def hchannelThreadts
        channel_ts = aURLs.map{|url| url.split('/')[4..5].reverse}.to_h
      end

    end
  end
end