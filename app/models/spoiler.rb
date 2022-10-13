class Spoiler < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :genre_spoiler_id
    validates :creator_spoiler_id
    validates :story_line_spoiler_id
    validates :release_date_spoiler_id
    validates :comment_spoiler_id
  end
end
