class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :likes, dependent: :destroy

  with_options presence: true do
    validates :comment
    validates :title
  end
end
