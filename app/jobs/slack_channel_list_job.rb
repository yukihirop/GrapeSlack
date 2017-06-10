class SlackChannelListJob < ApplicationJob

  queue_as :slack_channel

  include GrapeSlack::Api::ChannelGetable

  def perform
    set_slack_channel
  end

  private
  def set_slack_channel
    channel_attribute = Redis::HashKey.new('slack_channel:name')
    channel_list.each do |key, val|
      channel_attribute[key]=val
    end
  end

end
