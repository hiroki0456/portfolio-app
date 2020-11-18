class Question < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :category
    validates :title
    validates :question
  end
  
  # カテゴリーはそこまで増加しない想定のため、
  # enumを使用する
  enum category: {
        "生について": 0,
        "死について": 1,
        "愛について": 2,
        "運命について": 3,
        "結婚について": 4,
        "子供について": 5,
        "思考について": 6,
        "自由について": 7,
        "優しさについて": 8
      }
end
