class ContentForm
  include ActiveModel::Model

  attr_accessor :title, :category_id, :story_line, :release_date, :user_id, :id, :created_at, :updated_at, :genre_name

  with_options presence: true do
    validates :title
    validates :category_id
    validates :story_line
    validates :release_date
  end

  def save
    content = Content.create(
      title: title, category_id: category_id, story_line: story_line, release_date: release_date,
    )
    genre = Genre.where(genre_name: genre_name).first_or_initialize
    genre.save
    ContentGenreRelation.create(content_id: content.id, genre_id: genre.id)
  end
end