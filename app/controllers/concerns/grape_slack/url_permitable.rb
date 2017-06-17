module GrapeSlack
  module URLPermitable
    include GrapeSlack::Api::ChannelGetable

    def permit_contents_params(remake_contents_params={})
      @permit_contents_params = []
      permit_slack_channel(remake_contents_params)
      @permit_contents_params
    end

    private
    def permit_slack_channel(remake_contents_params)
      @permit_contents_params = remake_contents_params.select{|content_param|
        permit_channel?(
            content_param[:slack_url],
            Settings.slack[:permit_channel]
        )
      }
      # @remake_contents_paramsには空のcontentインスタンスが入ってないと
      # validateがかからない。
      @permit_contents_params << {:slack_url => ""} if @permit_contents_params.blank?
    end

    def permit_channel?(slack_url, channel_name)
      @channels_list = channel_list_from_redis
      if @channels_list
        #https://aiming.slack.com/archives/<channel>/<thread_ts>
        channel = slack_url.split('/')[4]
        channel == @channels_list[channel_name]
      else
        false
      end
    end
  end
end