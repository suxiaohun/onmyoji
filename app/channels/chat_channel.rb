class ChatChannel < ApplicationCable::Channel

  # Called when the consumer has successfully become a subscriber to this channel
  def subscribed
    stream_from "chat"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

    # ActionCable.server.broadcast 'chat',
    #                              message: '11111111',
    #                              user: 'aaa',
    #                              color:'purple'

  end

  def receive(data)
    data[:user] = current_user

    ActionCable.server.broadcast("chat", data)
  end
end
