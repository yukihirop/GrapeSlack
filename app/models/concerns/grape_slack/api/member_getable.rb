require 'slack'
module GrapeSlack
  module Api
    module MemberGetable

      MEMBER_ATTRIBUTES = %W[name first_name last_name image_48].freeze

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
        execute_member_from_redis
        #本来ならnilを返すべきだが、contentのbefore_validationで呼び出す
        #ことを想定しているのでnilではROLLBACKがかからない。
        #故にfalseを返す必要がある。
        (@member_from_redis.values.all?) ? @member_from_redis : false
      end

      private
      def execute_member_from_redis
        @member_from_redis = {}
        MEMBER_ATTRIBUTES.each do |attribute|
          begin
            member_from_redis_with_timeout(attribute)
          rescue Timeout::Error
            member_from_redis_with_rescue(attribute)
            break
          end
        end
        @member_from_redis
      end

      def member_from_redis_with_timeout(attribute)
        Timeout.timeout(Settings.redis[:hgetall][:timeout]) do
          while @member_from_redis[attribute].blank?
            @member_from_redis[attribute] = Redis.current.hgetall("slack_member:#{attribute}")
          end
        end
      end

      def member_from_redis_with_rescue(attribute)
        if is_a?(Content)
          errors[:base] << "Slackメンバー取得のタイムアウトエラー"
          @member_from_redis[attribute] = nil
        else
          #TODO: loggerで次回プルリクの際警告を出す。
        end
      end

    end
  end
end
