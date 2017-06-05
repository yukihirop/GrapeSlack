redis_config = YAML.load_file(Rails.root + 'config/redis.yml')[Rails.env]
Resque.redis = Redis.new(redis_config)
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }