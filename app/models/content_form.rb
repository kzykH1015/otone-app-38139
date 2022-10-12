class ContentForm
  include ActiveModel::Model

  attr_accessor(
    :title, :category_id, :story_line, :release_date, :user_id,
    :id, :created_at, :updated_at,
    :genre_name, :creator_name
  )

  with_options presence: true do
    validates :title
    validates :category_id
    validates :story_line
    validates :release_date
    validates :user_id
    validates :genre_name
    validates :creator_name
  end

  def save
    content = Content.create(
      title: title, category_id: category_id, story_line: story_line, release_date: release_date, user_id: user_id
    )
    genre = Genre.where(genre_name: genre_name).first_or_initialize
    genre.save
    ContentGenreRelation.create(content_id: content.id, genre_id: genre.id)

    creator = Creator.where(creator_name: creator_name).first_or_initialize
    creator.save
    ContentCreatorRelation.create(content_id: content.id, creator_id: creator.id)
  end

  def update(params, content)
    content.content_genre_relations.destroy_all
    content.content_creator_relations.destroy_all

    genre_name = params.delete(:genre_name)
    creator_name = params.delete(:creator_name)

    genre = Genre.where(genre_name: genre_name).first_or_initialize if genre_name.present?
    creator = Creator.where(creator_name: creator_name).first_or_initialize if creator_name.present?

    genre.save if genre_name.present?
    creator.save if creator_name.present?

    content.update(params)

    ContentGenreRelation.create(content_id: content.id, genre_id: genre.id) if genre_name.present?
    ContentCreatorRelation.create(content_id: content.id, creator_id: creator.id) if creator_name.present?
  end
end
