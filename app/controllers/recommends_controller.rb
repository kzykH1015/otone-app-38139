class RecommendsController < ApplicationController
  def new
    @content = Content.find(params[:content_id])
    @users = User.all
  end
end
