class PhilosopherProfile < ApplicationRecord
  belongs_to :user

  validate :philosopher?

  def philosopher?
    if !self.user.philosopher
      errors.add(:user, "哲学者のみが登録可能です")
    end 
  end
end
