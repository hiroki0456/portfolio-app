class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: {message: "は必須です"} do
    validates :nickname
    validates :gender
  end

  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,20}+\z/i, message: "半角英数字混合の6~20桁で入力してください"}

  enum gender: {
        female: 0,
        male: 1,
        other: 2,
        not_apply: 4
      }
end
