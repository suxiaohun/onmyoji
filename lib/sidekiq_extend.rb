module SidekiqExtend
  extend ActiveSupport::Concern

  included do
    attr_accessor :sidekiq_options
  end
end