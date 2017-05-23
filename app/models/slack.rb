require 'bundler'
Bundler.require

require 'slack'
require 'yaml'
require 'pry'
require 'uri'

# slack
Slack.configure do |config|
  config.token =  ENV['TOKEN'] || Thread.current[:request].session[:token]
end

module GrapeSlackString
  refine String do
    def to_unix
      delete('p').insert(-7,'.')
    end
  end
end


module GrapeSlack
  class Slack

    attr_accessor :tURLs, :client
    attr_reader :results
    USER_OPTIONS = %W[name first_name last_name image_48]

    def initialize(attributes = nil)
      @log = Logger.new('/tmp/log')
      @results = {}
      attributes.each do |k,v|
        send("#{k.to_s}=", v) if respond_to?("#{k.to_s}=")
      end if attributes
      yield self if block_given?
    end

    using GrapeSlackString
    def replies
      @log.info('リプライ一覧を取得します。')

      @results.delete('replies') unless @results.empty?
      replies = []

      hchannelThreadts.each do |channel,thread_ts|
        replies << client.channels_replies(channel: channel, thread_ts: thread_ts.to_unix)
      end

      replies.map!{|rep| rep['messages']}.compact!.flatten!
      replies.each_with_index do |el, i|
        el.delete('type')
        el['id'] = el['user']
        el.store('user', users['name'][el['user']])
        el['text'].gsub!(/<@(.+?)>/){"@#{users['name'][$1]}"}
      end

      @results['replies'] = replies

    end

    def users
      @log.info('チームメンバー一覧を取得します。')

      @results.delete('users') unless @results.empty?
      @users ||= {}

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
      @log.info('有効なURLかどうか検査しています。')
      @aURLs = URI.extract(tURLs, ['https']).map{|str| str.split(',')}
      @aURLs.flatten!.grep(/https:\/\/aiming.slack.com\/archives/)
    end

    def hchannelThreadts
      channel_ts = aURLs.map{|str| str.split('/')[4..5]}.to_h
    end

  end

end



res = GrapeSlack::Slack.new do |gs|
  gs.client = Slack.client
  gs.tURLs = 'https://aiming.slack.com/archives/C0BL9SDCM/p1495016704352847,
https://aiming.slack.com/archives/C5GACEUP6/p1495454313686993
https://aiming.slack.com/archives/C0aa9SDCM/p1495032304352847,fafafafafafa
https://aiming.slack.com/archives/C0BL9faCM/p1495013204352847
https://aiming.slack.com/archives/C0BL9SfaM/p1495015504352847'
  gs.replies
  gs.users
end

binding.pry

p