require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'not all clear' do
    it 'card情報が正しく登録できること' do
      payjp_client_mock = double('Payjp client')
      allow(payjp_client_mock).to receive(:card_create).and_return(customer_id: "cus_xxxxx", card_id: "xxxxxxxxx")
      card = Card.new(user_id: user.id,customer_id: payjp_client_mock.card_create[:customer_id], card_id: payjp_client_mock.card_create[:card_id])
      expect{card.save}.to change{Card.count}.by(1)
    end
  end
end