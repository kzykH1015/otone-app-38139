class LikesController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @content = Content.find(params[:id])
  end

  def create
  end

  def delete
  end
end
