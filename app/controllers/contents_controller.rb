class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @content = Content.find(params[:id])
    @user = User.find(@content.user_id)
  end

  private

  def content_params
    params.require(:content).permit(:title, :category_id, :story_line, :release_date).merge(user_id: current_user.id)
  end
end
