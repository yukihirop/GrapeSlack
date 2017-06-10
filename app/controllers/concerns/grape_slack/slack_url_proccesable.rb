module GrapeSlack
  module SlackUrlProccesable

    include GrapeSlack::Api::URLParserable
    include GrapeSlack::Api::URLPermitable

    def contents_params_after_treatment(txt_slack_urls)
      @remake_contents_params = remake_contents_params(txt_slack_urls)
      @permit_contents_params = permit_contents_params(@remake_contents_params)
      permit_contents_params_with_flash
    end

    private
    def permit_contents_params_with_flash
      #slackチャンネルの取得タイムアウトエラー
      if flash[:danger_channel_timeout]
        return
      elsif @remake_contents_params.first[:slack_url].empty?
        flash[:danger_invalid_url] = '入力さたSlackURLの形式がhttps://aiming.slack.com/archivesではありません.'
        return
      elsif @permit_contents_params.first[:slack_url].empty?
        flash[:danger_invalid_url] = '入力されたSlackURLに#randomチャンネルのものが含まれていません.'
        return
      end
      @permit_contents_params
    end

  end
end