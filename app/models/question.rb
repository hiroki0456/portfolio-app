class Question < ApplicationRecord
  # active_hashのassociation
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  # 通常のassociation
  belongs_to :user

  # validation
  with_options presence: true do
    validates :category_id, numericality: {other_than: 0, message: 'Select'}
    validates :title, length: {maximum: 20}
    validates :question, length: {maximum: 1000}
  end
end
