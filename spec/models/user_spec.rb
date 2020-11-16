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
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "can't validate gender for nil" do
      user.gender = ""
      user.valid?
      expect(user.errors.full_messages).to include("Gender can't be blank")
    end

    it "can't validate password for nil" do
      user.password = ""
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "can't validate password for only English" do
      user.password = "testteset"
      user.valid?
      expect(user.errors.full_messages).to include("Password can be set using half-width English numbers and letters, using more than 6 characters but less than 20.")
    end

    it "can't validate password for only Number" do
      user.password = "12345678"
      user.valid?
      expect(user.errors.full_messages).to include("Password can be set using half-width English numbers and letters, using more than 6 characters but less than 20.")
    end

    it "can't validate password less than 6" do
      user.password = "test1"
      user.valid?
      expect(user.errors.full_messages).to include("Password can be set using half-width English numbers and letters, using more than 6 characters but less than 20.")
    end

    it "can't validate, if password and password_confirmation don't match" do
      user.password = "test1"
      user.password_confirmation = "tese2"
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "can't validate email for nil" do
      user.email = ""
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "can't validate email, not to include '@'" do
      user.email = "test123"
      user.valid?
      expect(user.errors.full_messages).to include("Email is invalid")
    end
  end
end
