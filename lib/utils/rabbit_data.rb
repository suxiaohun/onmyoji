module RabbitData
  class << self

    def cc
      data = {}
      data[:account_id] = '4ad63542-be7a-41b8-4930-86b0dd9dadd7'
      data[:product_id] = 1
      data[:consume_goods_id] = 5 # 5.out_mobile:呼出手机
      data[:deduction_type] = 0

      data[:details] = {}
      data[:details][:call_id] = '53a667cd-5b1c-4199-4766-123456789'

      # data[:details][:channel_id] = '53a667cd-5b1c-4199-4766-123456789'
      data[:details][:agent_id] = 111
      data[:details][:agent_name] = 'xiaosu'
      data[:details][:call_direction] = 'outCallback'
      data[:details][:start_time] = Time.now.to_i
      data[:details][:end_time] = (Time.now + 2.minutes).to_i
      data[:details][:caller_number] = '12345'
      data[:details][:called_number] = '99995'
      data[:details][:duration] = 120
      data[:details][:spnumber] = '02160554657'
      data
    end


    def publish
      ch = RabbitMQ.channel
      queue_name = '29639cdd-7b43-4af8-7c52-929c2a39515b'
      q = ch.queue(queue_name, durable: true)

      q.publish(RabbitData.cc.to_json)
    end

  end
end