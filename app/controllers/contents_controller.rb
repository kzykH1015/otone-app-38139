class ContentsController < ApplicationController
  def index
    @contents = Content.all
  end

  def new
    @content_form = ContentForm.new
  end

  def create
    @content_form = ContentForm.new(content_form_params)
    if @content_form.valid?
      @content_form.save
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

  def content_form_params
    params.require(:content_form).permit(:title, :category_id, :story_line, :release_date, :genre_name, :creator_name).merge(user_id: current_user.id)
  end
end
