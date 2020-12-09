FactoryBot.define do
  factory :comment do
    comment { "MyText" }
    user { nil }
    question { nil }
  end
end
