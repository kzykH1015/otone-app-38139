class ContentsController < ApplicationController
  before_action :find_content, only: [:show, :edit, :update]
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
    @user = User.find(@content.user_id)
  end

  def edit
    content_attributes = @content.attributes
    @content_form = ContentForm.new(content_attributes)
    @content_form.genre_name = @content.genre&.first&.genre_name
    @content_form.creator_name = @content.creator&.first&.creator_name
  end
  
  def update
    @content_form = ContentForm.new(content_form_params)

    if @content_form.valid?
      @content_form.update(content_form_params, @content)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def content_form_params
    params.require(:content_form).permit(:title, :category_id, :story_line, :release_date, :genre_name, :creator_name).merge(user_id: current_user.id)
  end

  def find_content
    @content = Content.find(params[:id])
  end
end