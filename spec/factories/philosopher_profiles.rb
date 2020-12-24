FactoryBot.define do
  factory :philosopher_profile do
    profile { "MyText" }
    affiliation { "MyString" }
    research { "MyText" }
    user { nil }
  end
end
