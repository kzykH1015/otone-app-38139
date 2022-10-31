class ContentForm
  include ActiveModel::Model

  attr_accessor(
    :title, :category_id, :story_line, :release_date, :user_id,
    :id, :created_at, :updated_at,
    :genre_name, :creator_name
  )

  with_options presence: true do
    validates :title, uniqueness: true
    validates :category_id
    validates :genre_name
    validates :creator_name
    validates :story_line
    validates :release_date
    validates :user_id, on: :create
  end

  def save(genre_list, creator_list)
    content = Content.create(
      title: title, category_id: category_id, story_line: story_line, release_date: release_date, user_id: user_id
    )
    genre_list.each do |g_name|
      genre = Genre.where(genre_name: g_name).first_or_initialize
      genre.save
      ContentGenreRelation.create(content_id: content.id, genre_id: genre.id)
    end

    creator_list.each do |c_name|
      creator = Creator.where(creator_name: c_name).first_or_initialize
      creator.save
      ContentCreatorRelation.create(content_id: content.id, creator_id: creator.id)
    end
  end

  def update(params, content, genre_list, creator_list)
    genre_list.each do |g_name|
      content.content_genre_relations.destroy_all
      genre_name = params.delete(:genre_name)
      genre = Genre.where(genre_name: g_name).first_or_initialize if g_name.present?
      genre.save if g_name.present?
      ContentGenreRelation.create(content_id: content.id, genre_id: genre.id) if g_name.present?
    end

    creator_list.each do |c_name|
      content.content_creator_relations.destroy_all
      creator_name = params.delete(:creator_name)
      creator = Creator.where(creator_name: c_name).first_or_initialize if c_name.present?
      creator.save if c_name.present?
      ContentCreatorRelation.create(content_id: content.id, creator_id: creator.id) if c_name.present?
    end

    content.update(params)
  end
end
