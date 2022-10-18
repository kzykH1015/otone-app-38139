FactoryBot.define do
  factory :content_form do
    title             { 'devilmaycry5' }
    category_id       { 1 }
    genre_name        { 'devil' }
    creator_name      { 'capcom' }
    story_line        { 'arasuji' }
    release_date      { "2022/10/15" }
    user_id           { 3 }
  end
end
