unless Rails.env.test?
  namespace = [Rails.application.class.parent_name, Rails.env].join ':'
  redis_config = YAML.load(ERB.new(File.new(Rails.root + 'config/redis.yml.erb').read).result)[Rails.env]
  Redis.current = Redis::Namespace.new(namespace, redis: Redis.new(redis_config))
else
  Redis.current = Redis.new
end


