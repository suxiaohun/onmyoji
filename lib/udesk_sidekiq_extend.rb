module UdeskSidekiqExtend
  extend ActiveSupport::Concern

  included do
    attr_accessor :sidekiq_options
  end
end