class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :gender
  end
  
  # 安全性を担保するために、半角英数字混合のパスワードのみを受け入れる
  # 文字数は6~20で設定する。しかし、6文字では安全性を十分に担保できるかは不明
  # ユーザーの利用頻度を考慮すると6文字くらいでないと覚えられない可能性がある
  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,20}+\z/i, message: "can be set using half-width English numbers and letters, using more than 6 characters but less than 20."}

  enum gender: {
        female: 0,
        male: 1,
        other: 2,
        not_apply: 4
      }
end
