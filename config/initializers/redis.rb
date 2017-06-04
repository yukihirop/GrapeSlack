namespace = [Rails.application.class.parent_name, Rails.env].join ':'
case Rails.env
  when 'production'
    Redis.current = Redis::Namespace.new(namespace, redis: Redis.new(host: '127.0.0.1', port: 6379))
  when 'test'
    Redis.current = Redis::Namespace.new(namespace, redis: Redis.new(host: '127.0.0.1', port: 6379))
  when 'development'
    Redis.current = Redis::Namespace.new(namespace, redis: Redis.new(host: '127.0.0.1', port: 6379))
end