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
      # @remake_contents_paramsには空のcontentインスタンスが入ってないと
      # validateがかからない。
      (arr_slack_urls.blank?) ?
          into_content_params {@remake_contents_params << {slack_urll: given_urls} if arr_slack_urls.blank?} :
          into_content_params(given_urls, arr_slack_urls)
    end

    def into_content_params(given_urls="", arr_slack_urls=[], &block)
      return yield if block_given?
      arr_slack_urls.each do |slack_url|
        copy_content_params = {}
        copy_content_params['slack_url'] = slack_url
        @remake_contents_params << copy_content_params
      end
    end

  end

end