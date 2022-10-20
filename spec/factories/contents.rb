FactoryBot.define do
  factory :content do
    title             { 'devilmaycry5' }
    category_id       { 1 }
    story_line        { 'arasuji' }
    release_date      { '2022/10/15' }
    user
  end
end
