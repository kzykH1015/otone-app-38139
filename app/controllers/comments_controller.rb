class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @content = Content.find(params[:content_id])

  end

  def destroy
    @commnet = Comment.find(params[:content_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_text).merge(
      user_id: current_user.id, content_id: params[:content_id]
    )
  end
end
