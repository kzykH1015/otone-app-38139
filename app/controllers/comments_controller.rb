class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @content = Content.find(params[:content_id])
    CommentChannel.broadcast_to @content, { comment: @comment, user: @comment.user } if @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to content_path(@comment.content_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text).merge(user_id: current_user.id, content_id: params[:content_id])
  end
end
