require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Onmyoji
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.encoding = "utf-8"
    config.time_zone = "Beijing"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # 解决cors问题
    config.action_dispatch.default_headers = {
        'Access-Control-Allow-Origin' => 'http://linapp.udeskcat.com',
        'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",")
    }

    config.generators do |g|
      g.assets false
      g.helper false
      # g.test_framework nil
    end

  end
end
