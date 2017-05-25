require_relative 'content_api'

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
  include GrapeSlack::Content::Api

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
    @copy_params.merge!({'nickname'       => replie['user']})
    @copy_params.merge!({'slack_message'  => replie['text']})
    @copy_params.merge!({'slack_url'      => "https://aiming.slack.com/#{replie['id']}/#{replie['ts'].to_p}"})
    from_users(replie['id'])
  end

  def from_users(id)
    # こちらはhash
    users = @results['users']
    @copy_params.merge!({'first_name'     => users['first_name'][id]})
    @copy_params.merge!({'last_name'      => users['last_name'][id]})
    @copy_params.merge!({'name'           => "#{users['first_name'][id]} " + ' ' + "#{users['last_name'][id]}"})
    @copy_params.merge!({'profile_image_48_url' => users['image_48'][id]})
  end

  def each_after_remake
    @remake_params_arr << @copy_params
  end


end
