require 'channel'

module GrapeSlack

  class URLPermit

    attr_reader :permit_contents_params

    def initialize(remake_contents_params={})
      @permit_contents_params = []
      permit_slack_channel(remake_contents_params)
    end

    private
    def permit_slack_channel(remake_slack_params)
      @permit_contents_params = remake_slack_params.select{|slack_url_param|
        permit_channel(
            slack_url_param[:slack_url],
            Settings.slack[:permit_channel]
        )
      }
      # @remake_contents_paramsには空のcontentインスタンスが入ってないと
      # validateがかからない。
      @permit_contents_params << {slack_url: ""} if @permit_contents_params.blank?
    end

    def permit_channel(slack_url, channel_name)
      @channels_list ||= {}
      while @channels_list.empty?
        @channels_list = GrapeSlack::Api::Channel.new.list_from_redis
      end
      slack_url.split('/')[4] == @channels_list[channel_name]
    end

  end

end