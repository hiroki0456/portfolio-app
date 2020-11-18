FactoryBot.define do
  factory :question do
    category { 1 }
    text { "MyString" }
    title { "MyString" }
    question { "MyText" }
    user { nil }
  end
end
