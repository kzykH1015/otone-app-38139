class ContentsController < ApplicationController
  before_action :find_content, only: [:show, :edit, :update]
  before_action :move_login, except: :index
  before_action :before_content_data, only: :update

  def index
    @contents = Content.all.order(created_at: :desc)
  end

  def new
    @content_form = ContentForm.new
  end

  def create
    @content_form = ContentForm.new(content_form_params)
    genre_list = params[:content_form][:genre_name].split(' ')
    creator_list = params[:content_form][:creator_name].split(' ')
    if @content_form.valid?
      @content_form.save(genre_list, creator_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(@content.user_id)
    @comments = Comment.all
    @comment = Comment.new
    @spoiler = Spoiler.find_by(user_id: current_user.id)
    @histories = History.where(content_id: @content.id).order(created_at: :desc)
  end

  def edit
    content_attributes = @content.attributes
    @content_form = ContentForm.new(content_attributes)

    @genres = Genre.where(content_id: @content.id)
    @genre_list = @content.genre.map { |genre| genre.genre_name }
    @content_form.genre_name = @genre_list

    @creators = Creator.where(content_id: @content.id)
    @creator_list = @content.creator.map { |creator| creator.creator_name }
    @content_form.creator_name = @creator_list
  end

  def update
    @content_form = ContentForm.new(content_update_params)
    genre_list = params[:content_form][:genre_name].split(' ')
    creator_list = params[:content_form][:creator_name].split(' ')
    if @content_form.valid?
      @content_form.update(content_update_params, @content, genre_list, creator_list)
      # binding.pry
      edit_message = ''

      edit_message += '「タイトル」' if @c_form.title != @content_form.title
      edit_message += '「発売日・放送日」' if @c_form.release_date != @content_form.release_date.to_date
      edit_message += '「ジャンル」' if @g_list != genre_list
      edit_message += '「制作者・会社名」' if @cre_list != creator_list
      edit_message += '「あらすじ」' if @c_form.story_line != @content_form.story_line
      edit_message += '「カテゴリー」' if "#{@c_form.category_id}" != @content_form.category_id

      History.create_log(params[:id], current_user.id, "#{edit_message}") if edit_message != ''

      redirect_to content_path(params[:id])
    else
      render :edit
    end
  end

  def search_content
    if params[:q]&.dig(:title)
      squished_keywords = params[:q][:title].squish
      params[:q][:title_cont_any] = squished_keywords.split(' ')
    end

    @q = Content.ransack(params[:q])
    @results = @q.result.includes(:genre)
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

  def content_update_params
    params.require(:content_form).permit(:title, :category_id, :story_line, :release_date, :genre_name,
                                         :creator_name)
  end

  def find_content
    @content = Content.find(params[:id])
  end

  def move_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def before_content_data
    c_attributes = @content.attributes
    @c_form = ContentForm.new(c_attributes)

    @g = Genre.where(content_id: @content.id)
    @g_list = @content.genre.map { |genre| genre.genre_name }
    @c_form.genre_name = @g_list

    @cre = Creator.where(content_id: @content.id)
    @cre_list = @content.creator.map { |creator| creator.creator_name }
    @c_form.creator_name = @cre_list
  end
end
