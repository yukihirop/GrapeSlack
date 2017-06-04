require 'slack'

module GrapeSlack
  module Api
    class Member

      attr_reader :member, :member_from_redis
      MEMBER_ATTRIBUTES = %W[name first_name last_name image_48]

      def member
        @member ||= {}
        return @member if @member.present?
        @users_list ||= Slack.client.users_list['members']
        MEMBER_ATTRIBUTES.each do |attribute|
          if attribute == 'name'
            @member[attribute] = @users_list.map{ |m| [ m['id'], m[attribute] ] }.to_h
          else
            @member[attribute] = @users_list.map{ |m| [ m['id'], m['profile'][attribute] ] }.to_h
          end
        end
        @member
      end


      def member_from_redis
        @member_from_redis ||= {}
        MEMBER_ATTRIBUTES.each do |attribute|
          @member_from_redis[attribute] = Redis.current.hgetall("slack_member:#{attribute}")
        end
        @member_from_redis
      end

    end
  end
end