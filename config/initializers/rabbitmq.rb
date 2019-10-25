class RabbitMQ
  # 注意下面名为galaxy（根据自己业务起名字）的Exchange是提前在web控制台上面创建好的，并和名为galaxy.queue的队列做好
  # 了类型为direct的绑定，这样exchange为galaxy的消息，就会发送到名为galaxy.queue的queue中，提供给后续的seakers消费
  EXCHANGE = "galaxy"
  TYPE = "direct"
  DURABLE = true
  class << self
    # 全局创建一个单例@conn，这样一个应用只会和RabbmitMQ服务器建立一条TCP连接
    # 这里的ENV['MQ_PD_CNN']，配置在环境变量里面，例如: amqp://user_name:password@rabbitmq_server_ip
    def connection
      rabbitmq_url = "amqp://Udesk:Udesk2019@39.106.208.100/billing_paas"
      @conn ||= Bunny.new(rabbitmq_url).start
    end

    # 一个TCP connnection上面可以创建多个信道channel
    def channel
      @ch = connection.create_channel
    end

    def publish(exchange, message = {})
      exchange.publish(message)
    end
  end
end