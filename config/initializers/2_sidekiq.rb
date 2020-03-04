# module ActiveJob
#   class Base
#     include SidekiqExtend
#   end
# end

#
# module ActiveJob
#   module QueueName
#     module ClassMethods
#       def sidekiq_options(*args)
#         # self.sidekiq_options = args
#       end
#     end
#   end
# end

module ActiveJob
  module QueueAdapters

    class SidekiqAdapter
      def enqueue(job) #:nodoc:
        # Sidekiq::Client does not support symbols as keys
        _options = job.class.get_sidekiq_options.dup
        _options.keys.each do |key|
          _options[key.to_s] = _options.delete(key)
        end

        _params = {}
        _params["class"] = JobWrapper
        _params["wrapped"] = job.class.to_s
        _params["queue"] = _options["queue"] || job.queue_name
        _params["args"] = [job.serialize]
        _params["retry"] = _options["retry"] || 3

        if _options["pool"]
          job.provider_job_id = Sidekiq::Client.new(_options["pool"]).push \
          "class" => JobWrapper,
          "wrapped" => job.class.to_s,
          "queue" => _options["queue"] || job.queue_name,
          "args" => [job.serialize],
          "retry" => _options["retry"] || 3
        else
          job.provider_job_id = Sidekiq::Client.push \
          "class" => JobWrapper,
          "wrapped" => job.class.to_s,
          "queue" => _options["queue"] || job.queue_name,
          "args" => [job.serialize],
          "retry" => _options["retry"] || 3
        end
      end

      def enqueue_at(job, timestamp) #:nodoc:
        _options = job.class.get_sidekiq_options.dup
        _options.keys.each do |key|
          _options[key.to_s] = _options.delete(key)
        end

        _params = {}
        _params["class"] = JobWrapper
        _params["wrapped"] = job.class.to_s
        _params["queue"] = _options["queue"] || job.queue_name
        _params["args"] = [job.serialize]
        _params["retry"] = _options["retry"] || 3
        _params["at"] = timestamp

        if _options["pool"]
          job.provider_job_id = Sidekiq::Client.new(_options["pool"]).push \
          "class" => JobWrapper,
          "wrapped" => job.class.to_s,
          "queue" => _options["queue"] || job.queue_name,
          "args" => [job.serialize],
          "retry" => _options["retry"] || 3,
          "at" => timestamp
        else
          job.provider_job_id = Sidekiq::Client.push \
          "class" => JobWrapper,
          "wrapped" => job.class.to_s,
          "queue" => _options["queue"] || job.queue_name,
          "args" => [job.serialize],
          "retry" => _options["retry"] || 3,
          "at" => timestamp
        end
      end
    end
  end
end
