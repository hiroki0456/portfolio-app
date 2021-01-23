class UserProfile < ApplicationRecord
  before_save :set_default_value
  belongs_to :user

  validates :profile, presence: true
  def set_default_value
    if kleshas == nil
      self.kleshas = ""
    elsif research == nil
      self.research = ""
    end
  end
end
