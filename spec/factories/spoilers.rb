FactoryBot.define do
  factory :spoiler do
    genre_spoiler_id { 1 }
    creator_spoiler_id { 1 }
    story_line_spoiler_id { 1 }
    release_date_spoiler_id { 1 }
    comment_spoiler_id { 1 }

    user
  end
end
