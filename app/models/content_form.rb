class ContentForm
  include ActiveModel::Model

  attr_accessor(
    :title, :category_id, :story_line, :release_date, :user_id,
    :id, :created_at,:datetime, :updated_at,
    :genre_name, :creator_name
  )

  with_options presence: true do
    validates :title
    validates :category_id
    validates :story_line
    validates :release_date
  end

  def save
    content = Content.create(
      title: title, category_id: category_id, story_line: story_line, release_date: release_date
    )
    genre = Genre.where(genre_name: genre_name).first_or_initialize
    genre.save
    ContentGenreRelation.create(content_id: content.id, genre_id: genre.id)

    creator = Creator.where(creator_name: creator_name).first_or_initialize
    creator.save
    ContentCreatorRelation.create(content_id: content.id, creator_id: creator.id)
  end
end