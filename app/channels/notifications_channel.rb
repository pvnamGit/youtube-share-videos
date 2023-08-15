class NotificationsChannel < ApplicationCable::Channel

  def subscribed
    stream_from "notifications_channel_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

end
