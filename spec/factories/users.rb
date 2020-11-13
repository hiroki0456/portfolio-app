FactoryBot.define do
  factory :user do
    nickname              {"taro"}
    gender                {"male"}
    email                 {"test123@example.com"}
    password              {"passw0rd"}
    password_confirmation {password}
  end
end
