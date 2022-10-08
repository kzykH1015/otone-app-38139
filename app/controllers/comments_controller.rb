class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @content = Content.find(params[:content_id])
    if @comment.save
      CommentChannel.broadcast_to @content, { comment: @comment, user: @comment.user }
    end
  end

  def destroy
    @commnet = Comment.find(params[:content_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_text).merge(user_id: current_user.id, content_id: params[:content_id])
  end
end
