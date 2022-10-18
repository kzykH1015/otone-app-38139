FactoryBot.define do
  factory :comment do
    comment_text   { Faker::Lorem }

    user
    content
  end
end
