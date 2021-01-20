class PhilosopherProfile < ApplicationRecord
  belongs_to :philosopher, class_name: "User", foreign_key: "user_id"
end
