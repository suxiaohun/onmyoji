# config.redis = { :namespace => 'myapp', :size => 25, :url => 'redis://myhost:8877/0' }
# PROJ = {namespace: 'proj', size: 25, url: 'redis://127.0.0.1:6379/0'}
proj_redis_config = {}
proj_redis_config[:host] = "localhost"
proj_redis_config[:port] = 6379
proj_redis_config[:db]   = Rails.env.test? ? 3 : 0


PROJ_REDIS              = Redis.new(proj_redis_config)
PROJ_SIDEKIQ_NAMESPACE  = Rails.env.production? ? :proj_sidekiq : :"proj_sidekiq_#{Rails.env}"
RPOJ_SIDEKIQ_REDIS      = Redis::Namespace.new(PROJ_SIDEKIQ_NAMESPACE, redis: PROJ_REDIS)
PROJ_SIDEKIQ_REDIS_POOL = ConnectionPool.new(timeout: 1) { RPOJ_SIDEKIQ_REDIS }

Sidekiq.configure_server do |config|
  config.redis = {namespace: 'kun_web', size: 25, url: 'redis://127.0.0.1:6379/0'}
end
Sidekiq.configure_client do |config|
  config.redis = {namespace: 'kun_web', size: 1, url: 'redis://127.0.0.1:6379/0'}
end