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
    @comments = Comment.all
    @comment = Comment.new
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
      redirect_to content_path(params[:id])
    else
      render :edit
    end
  end

  def search_content
    @q = Content.ransack(params[:q])
    @contents = @q.result
  end

  def search_genre
    return nil if params[:keyword] == ''

    genre = Genre.where(['genre_name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: genre }
  end

  def search_creator
    return nil if params[:keyword] == ''

    creator = Creator.where(['creator_name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: creator }
  end

  private

  def content_form_params
    params.require(:content_form).permit(:title, :category_id, :story_line, :release_date, :genre_name,
                                         :creator_name).merge(user_id: current_user.id)
  end

  def find_content
    @content = Content.find(params[:id])
  end
end
