class LikesController < ApplicationController
  def create
    @content_like = Like.new(user_id: current_user.id, content_id: params[:content_id])
    @content_like.save
    redirect_to content_path(params[:content_id])
  end

  def destroy
    @content_like = Like.find_by(user_id: current_user.id, content_id: params[:content_id])
    @content_like.destroy
    redirect_to content_path(params[:content_id])
  end
end
