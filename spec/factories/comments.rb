FactoryBot.define do
  factory :comment do
    comment { "MyText" }
    title { "MyTitle" }
    association :question
    association :user
  end
end
