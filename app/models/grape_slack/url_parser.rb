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
    def initialize(content_params={})
      @remake_contents_params = []
      arr_slack_urls = content_params['slack_url'].url_split
      arr_slack_urls.each do |slack_url|
        copy_content_params = Marshal.load(Marshal.dump(content_params))
        copy_content_params['slack_url'] = slack_url
        @remake_contents_params << copy_content_params
      end
      after(content_params)
    end

    def after(content_params={})
      @remake_contents_params << content_params if content_params[:slack_url] == ""
    end

  end

end