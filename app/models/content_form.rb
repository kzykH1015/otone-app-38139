class ContentForm
  include ActiveModel::Model

  attr_accessor :title, :category_id, :story_line, :release_date, :user_id

  with_options presence: true do
    validates :title
    validates :category_id
    validates :story_line
    validates :release_date
  end

  def save
    Content.create(
      title: title, category_id: category_id, story_line: story_line, release_date: release_date
    )
  end
end