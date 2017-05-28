module GrapeSlack

  refine String do
    def url_split
      arr_slack_urls = URI.extract(self, ['https']).map{|slack_url| slack_url.split(',')}
      arr_slack_urls.flatten.grep(/https:\/\/aiming.slack.com\/archives/).uniq
    end
  end

  class URLParser
    attr_reader :slack_urls

    using GrapeSlack
    # content_params = summary_params['contente_attributes']['0']
    # を指す
    def initialize(content_params={})
      @slack_urls = []
      arr_slack_urls = content_params['slack_url'].url_split
      arr_slack_urls.each do |slack_url|
        copy_content_params = Marshal.load(Marshal.dump(content_params))
        copy_content_params['slack_url'] = slack_url
        @slack_urls << copy_content_params
      end
    end
  end

end