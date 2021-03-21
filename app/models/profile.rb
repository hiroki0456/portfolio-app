class Profile < ApplicationRecord
  delegated_type :profile, types: %w[GeneralProfile PhilosopherProfile], dependent: :destroy
  belongs_to :user
end
