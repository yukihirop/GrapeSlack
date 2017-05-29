class SlackMembersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    p 'bbbbbbbb'
    redis = Redis.new(host: 'localhost', post: 6379)
    redis.hmset('foo',{:a=>1,:b=>2,:c=>4})
    #return if redis.exists?('slack_members')
    redis.hmset('slack_members', GrapeSlack::Api::Member.new.members.to_json)
    p redis.hmget('slack_members')
    p 'aaaaa'
  end
end
