require_relative 'grape_slack'

module GrapeSlackString
  refine String do
    # 例)123.456789->p123456789
    def to_p
      insert(0,'p').delete('.')
    end
  end
end


class Content < ApplicationRecord
  belongs_to :summary
  include GrapeSlack::Slack

  attr_accessor :params

  def remake_multi_records
    @results = preparate do |gs|
      gs.client=Slack.client
      gs.tURLs=slack_url
      # これは必ず書く
      gs.start
      # 取得したいもの(メソッド)を書く
      gs.replies
      gs.users
      # これは必ず必要
      gs.end
    end
    remake_params_arr
  end

  private

  def remake_params_arr
    @remake_params_arr = []
    @results['replies'].size.times do |n|
      each_before_remake
      from_replies(n)
      each_after_remake
    end
    @remake_params_arr
  end

  def each_before_remake
    @copy_params = Marshal.load(Marshal.dump(params))
  end

  using GrapeSlackString
  def from_replies(n)
    #n番目のreplie
    replie = @results['replies'][n]
    @copy_params['contents_attributes']['0'].merge!({'nickname'       => replie['user']})
    @copy_params['contents_attributes']['0'].merge!({'slack_message'  => replie['text']})
    @copy_params['contents_attributes']['0'].merge!({'slack_url'      => "https://aiming.slack.com/#{replie['id']}/#{replie['ts'].to_p}"})
    from_users(replie['user_id'])
  end

  def from_users(user_id)
    # こちらはhash
    users = @results['users']
    @copy_params['contents_attributes']['0'].merge!({'first_name'     => users['first_name'][user_id]})
    @copy_params['contents_attributes']['0'].merge!({'last_name'      => users['last_name'][user_id]})
    @copy_params['contents_attributes']['0'].merge!({'name'           => "#{users['last_name'][user_id]} + ' ' + #{users['first_name'][user_id]}"})
  end

  def each_after_remake
    @remake_params_arr << @copy_params
  end


end
