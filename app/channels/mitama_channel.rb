class MitamaChannel < ApplicationCable::Channel

  # Called when the consumer has successfully become a subscriber to this channel
  def subscribed
    stream_from "mitama"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    data['user'] = current_user unless data['user'].present?

    ActionCable.server.broadcast("mitama", data)
  end

end
