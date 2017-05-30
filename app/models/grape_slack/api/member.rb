require 'slack'

module GrapeSlack
  module Api
    class Member

      attr_reader :members
      MEMBER_OPTIONS = %W[name first_name last_name image_48]

      def initialize
        Slack.configure do |config|
          config.token = ENV['TOKEN']
        end
      end

      def members
        @members ||= {}
        return @members if @members.present?
        @users_list ||= Slack.client.users_list['members']
        MEMBER_OPTIONS.each do |opt|
          if opt == 'name'
            @members[opt] = @users_list.map{ |m| [ m['id'], m[opt] ] }.to_h
          else
            @members[opt] = @users_list.map{ |m| [ m['id'], m['profile'][opt] ] }.to_h
          end
        end
        @members
      end

    end
  end
end