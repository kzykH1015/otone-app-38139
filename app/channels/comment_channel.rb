class CommentChannel < ApplicationCable::Channel
  def subscribed
    @content = Content.find(params[:content_id])
    stream_for @content
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
