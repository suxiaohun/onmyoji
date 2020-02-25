Sidekiq.configure_server do |config|
  config.redis = {namespace: 'onmyoji', size: 25, url: 'redis://127.0.0.1:6379/0'}
end

Sidekiq.configure_client do |config|
  config.redis = {namespace: 'onmyoji', size: 1, url: 'redis://127.0.0.1:6379/0'}
end
