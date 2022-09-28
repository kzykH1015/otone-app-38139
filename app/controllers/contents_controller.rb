class ContentsController < ApplicationController
  def index
    @user = User.find(current_user.id)
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new
    if @content.save
      redirect_to root_path
    else
      render :new
    end
  end
end
