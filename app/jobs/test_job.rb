class TestJob < ApplicationJob
  queue_as :default1
  sidekiq_options :retry => false, :queue => "ssss", :pool => UDESK_PROJ_SIDEKIQ_REDIS_POOL


  def perform(*args)
    $worker_count ||= 1
    Sidekiq.logger.info "----#{$worker_count}--bbbbbbbbbbbbbbbbbbbbb"
    $worker_count += 1
    raise '===========su error'

    # Do something later
  end
end
