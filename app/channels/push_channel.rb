class PushChannel < ApplicationCable::Channel
  def subscribed
     stream_from "push"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
