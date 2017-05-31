require 'slack'

module GrapeSlack
  module Api
    class Member

      attr_reader :members
      MEMBER_ATTRIBUTES = %W[name first_name last_name image_48]

      def initialize
        Slack.configure do |config|
          config.token = ENV['TOKEN']
        end
      end

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

    end
  end
end