require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.build(:user)}

  context "all clear" do
    it 'can validate all attributes' do
      expect{user.save}.to change{User.count}.by(1)
    end
  end

  context "not all clear" do
    it "can't validate nickname for nil" do
      user.nickname = ""
      user.valid?
      expect(user.errors.full_messages).to include("Nickname は必須です")
    end

    it "can't validate nickname for nil" do
      user.nickname = ""
      user.valid?
      expect(user.errors.full_messages).to include("Nickname は必須です")
    end
  end
end
