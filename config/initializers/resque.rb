unless Rails.env.test?
  redis_config = YAML.load(ERB.new(File.new(Rails.root + 'config/redis.yml.erb').read).result)[Rails.env]
  Resque.redis = Redis.new(redis_config)
  Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
end
