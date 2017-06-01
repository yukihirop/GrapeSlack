class SlackChannelListJob < ApplicationJob

  queue_as :slack_channel

  def perform(override)
    #上書き作成もしくは既に存在してたらスルー
    override ? set_slack_channel :
               set_slack_channel { return if Redis.current.keys.include?('slack_channel:name')}
  end

  private
  def set_slack_channel(&block)
    block.call if block_given?
    channel_attribute = Redis::HashKey.new('slack_channel:name')
    GrapeSlack::Api::Channel.new.list['name'].each do |key, val|
      channel_attribute[key]=val
    end
  end
end
