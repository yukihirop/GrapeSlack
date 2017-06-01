class SlackMemberJob < ApplicationJob
  queue_as :default
  MEMBER_ATTRIBUTES = %W[name first_name last_name image_48]

  def perform(override)
    #上書き作成もしくは既に存在してたらスルー
    override ? set_slack_member :
               set_slack_member { return if Redis.current.keys.include?(MEMBER_ATTRIBUTES)}
  end

  private
  def set_slack_member(&block)
    block.call if block_given?
    MEMBER_ATTRIBUTES.each do |attribute|
      member_attribute = Redis::HashKey.new("slack_member:#{attribute}")
      GrapeSlack::Api::Member.new.member[attribute].each do |key, val|
        member_attribute[key]=val
      end
    end
  end

end


