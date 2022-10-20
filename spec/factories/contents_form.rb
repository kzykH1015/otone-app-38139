FactoryBot.define do
  factory :content_form do
    title             { Faker::Name.initials(number: 6) }
    category_id       { 1 }
    genre_name        { 'devil' }
    creator_name      { 'capcom' }
    story_line        { 'arasuji' }
    release_date      { '2000/10/15' }
    user_id           { 3 }
  end
end
