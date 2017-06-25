class SlackMemberJob < ApplicationJob

  queue_as :slack_member
  MEMBER_ATTRIBUTES = %W[name first_name last_name image_48].freeze

  include GrapeSlack::Api::MemberGetable

  def perform
    set_slack_member
  end

  private
  def set_slack_member
    MEMBER_ATTRIBUTES.each do |attribute|
      member_attribute = Redis::HashKey.new("slack_member:#{attribute}")
      member_attribute.bulk_set(member[attribute])
    end
  end

end


