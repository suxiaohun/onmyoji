class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    $worker_count ||= 1
    Sidekiq.logger.info "----#{$worker_count}--bbbbbbbbbbbbbbbbbbbbb"
    $worker_count += 1
    # Do something later
  end
end
