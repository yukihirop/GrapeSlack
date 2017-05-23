class Content < ApplicationRecord
  belongs_to :summary
  before_validation :set_content_attributes
  attr_reader :remake_params_arr

  def initialize(params = {})
    @params = params
  end

  def set_content_attributes

    res = GrapeSlack::Slack.new do |gs|
      gs.client = Slack.client
      gs.tURLs = slack_url
      # 取得したいものを書く
      gs.replies
      gs.users
    end


    @remake_params_arr = []
    res.results.each do |key|
      @copy_params = Marshal.load(Marshal.dump(params))
      case key
        when 'replies'
          @copy_params['slack_message'] = results['replies']['text']
        when 'users'
          @copy_params['first_name'] = results['users']['first_name']
          @copy_params['last_name'] = results['users']['last_name']
      end
      @remake_params_arr << @copy_params
    end

  end

end
