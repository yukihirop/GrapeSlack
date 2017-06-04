require 'channel'

module GrapeSlack

  refine String do
    def url_split
      arr_slack_urls = URI.extract(self, ['https']).map{|slack_url| slack_url.split(',')}
      arr_slack_urls.flatten.grep(/https:\/\/aiming.slack.com\/archives/).uniq
    end
  end

  class URLParser
    attr_reader :remake_contents_params

    using GrapeSlack
    # content_params = summary_params['contente_attributes']['0']
    # を指す
    def initialize(given_urls)
      @remake_contents_params = []
      arr_slack_urls = given_urls.url_split
      #  取得するchannelを制限する
      exclude_slack_channel(arr_slack_urls)
      # @remake_contents_paramsには空のcontentインスタンスが入ってないと
      # validateがかからない。
      (arr_slack_urls.blank?) ?
          add_content_params {@remake_contents_params << {slack_url: ""} if arr_slack_urls.blank?} :
          add_content_params(arr_slack_urls)
    end

    private
    def exclude_slack_channel(arr_slack_urls)
      arr_slack_urls.select!{|slack_url| channel_permit(slack_url, 'random')}
    end

    def channel_permit(slack_url, channel_name)
      @channels_list ||= GrapeSlack::Api::Channel.new.list_from_redis
      slack_url.split('/')[4] == @channels_list['name'][channel_name]
    end

    def add_content_params(arr_slack_urls=[], &block)
      return yield if block_given?
      arr_slack_urls.each do |slack_url|
        copy_content_params = {}
        copy_content_params['slack_url'] = slack_url
        @remake_contents_params << copy_content_params
      end
    end



  end

end