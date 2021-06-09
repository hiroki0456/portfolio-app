require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before do
    module PayjpMock
      def self.id
        return "cus_xxxxx"
      end

      def self.default_card
        return "xxxxxxxxx"
      end
    end
    allow(Card).to receive(:card_create).and_return(PayjpMock)
    allow(Card).to receive(:pay).and_return(PayjpMock)
  end
  describe 'not all clear' do
    it '支払いができること' do
      login_user user
      post :create, params: {card: {token: "tk_xxxxxxx}"}}
      expect(response.status).to eq(302)
    end
  end
end
