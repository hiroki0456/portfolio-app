require 'rails_helper'

RSpec.describe 'Cards', type: :system do
  let(:user) { FactoryBot.create(:user) }

  it 'card情報がcreateできる' do

    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    
    click_button 'ログイン'

    visit user_path(user.id)

    click_button 'オンライン質問し放題プランに変更する'

    fill_in 'card_card_number', with: 4242424242424242
    find("option[value='3']").select_option
    find("option[value='25']").select_option
    fill_in 'card_cvc', with: 123

    click_button 'カード情報を登録する'

    expect(Card.count).by(1)

    sleep 4
  end
end