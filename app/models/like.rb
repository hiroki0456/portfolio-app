class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user_id, uniqueness: { scope: :comment_id } 

  scope :filter_by_like, ->(comment_id) { where(comment_id: comment_id) if comment_id }
end