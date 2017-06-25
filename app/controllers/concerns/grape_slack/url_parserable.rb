module GrapeSlack
  module URLParserable

    refine String do
      def url_split
        arr_slack_urls = URI.extract(self, ['https']).map{|slack_url| slack_url.split(',')}
        arr_slack_urls.flatten.grep(/https:\/\/aiming.slack.com\/archives/).uniq
      end
    end

    using GrapeSlack::URLParserable
    def remake_contents_params(given_urls)
      @remake_contents_params = []
      add_content_params(given_urls.url_split)
      @remake_contents_params
    end

    private
    def add_content_params(arr_slack_urls=[])
      @remake_contents_params = arr_slack_urls.map{|slack_url| {:slack_url => slack_url} }
      # @remake_contents_paramsには空のcontentインスタンスが入ってないと
      # validateがかからない。
      @remake_contents_params << {:slack_url => ""} if arr_slack_urls.blank?
    end

  end

end