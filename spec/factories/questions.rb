FactoryBot.define do
  factory :question do
    category_id { 1 }
    title { "a" * 20 }
    question { "a" * 1000 }
    association :user
  end
end
