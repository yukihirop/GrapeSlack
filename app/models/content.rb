module GrapeSlackString
  refine String do
    def to_p
      insert(0,'p').delete('.')
    end
  end
end


class Content < ApplicationRecord
  belongs_to :summary
  before_validation :set_content_attributes
  attr_reader :remake_params_arr

  def initialize(params = {})
    @params = params
  end

  def set_content_attributes
    @res = GrapeSlack::Slack.new do |gs|
      gs.client = Slack.client
      gs.tURLs = slack_url
      # 取得したいもの(メソッド)を書く
      gs.replies
      gs.users
    end
    @results = @res.results
    remake_params_arr
  end

  private

  using GrapeSlackString
  def remake_params_arr
    @remake_params_arr = []
    @results.each do |key, value|
      v.each do |chil_key, chil_value|
        @copy_params = Marshal.load(Marshal.dump(params))
        case key
          when 'replies'
            @copy_params['nickname']      = chil_value['user']
            @copy_params['slack_message'] = chil_value['text']
            @copy_params['slack_url']     = "https://aiming.slack.com/#{chil_value['id']}/#{chil_value['ts'].to_p}"
          when 'users'
            @copy_params['first_name']    = chil_value['first_name']
            @copy_params['last_name']     = chil_value['last_name']
            @copy_params['name']          = chil_value['last_name'] + ' ' + chil_value['first_name']
        end
        @remake_params_arr << @copy_params
      end
    end
    @remake_params_arr
  end

end
