FactoryBot.define do
  factory :user_profile do
    profile { "MyText" }
    kleshas { "MyText" }
    user { nil }
  end
end
