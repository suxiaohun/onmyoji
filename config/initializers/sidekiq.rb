# config.redis = { :namespace => 'myapp', :size => 25, :url => 'redis://myhost:8877/0' }
# UDESK_PROJ = {namespace: 'proj', size: 25, url: 'redis://127.0.0.1:6379/0'}
udesk_proj_redis_config = {}
udesk_proj_redis_config[:host] = "localhost"
udesk_proj_redis_config[:port] = 6379
udesk_proj_redis_config[:db]   = Rails.env.test? ? 3 : 0


UDESK_PROJ_REDIS              = Redis.new(udesk_proj_redis_config)
UDESK_PROJ_SIDEKIQ_NAMESPACE  = Rails.env.production? ? :udesk_proj_sidekiq : :"udesk_proj_sidekiq_#{Rails.env}"
UDESK_RPOJ_SIDEKIQ_REDIS      = Redis::Namespace.new(UDESK_PROJ_SIDEKIQ_NAMESPACE, redis: UDESK_PROJ_REDIS)
UDESK_PROJ_SIDEKIQ_REDIS_POOL = ConnectionPool.new(timeout: 1) { UDESK_RPOJ_SIDEKIQ_REDIS }

Sidekiq.configure_server do |config|
  config.redis = {namespace: 'kun_web', size: 25, url: 'redis://127.0.0.1:6379/0'}
end
Sidekiq.configure_client do |config|
  config.redis = {namespace: 'kun_web', size: 1, url: 'redis://127.0.0.1:6379/0'}
end