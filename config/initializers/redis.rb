unless Rails.env.test?
  namespace = [Rails.application.class.parent_name, Rails.env].join ':'
  redis_config = YAML.load_file(Rails.root + 'config/redis.yml')[Rails.env]
  Redis.current = Redis::Namespace.new(namespace, redis: Redis.new(redis_config))
end
