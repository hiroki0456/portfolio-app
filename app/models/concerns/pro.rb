module Pro
  extend ActiveSupport::Concern

  included do
    has_one :profile, as: :profile, touch: true, dependent: :destroy
    delegate :content, to: :profile
  end
end