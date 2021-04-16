class Card < ApplicationRecord
  belongs_to :user

  def self.card_create(card_token)
    Payjp.api_key = "sk_test_d7339cf0cae7215730b6e296"
    customer = Payjp::Customer.create(
      card: card_token
    )
    return customer
  end

  def self.pay(current_user)
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = "sk_test_d7339cf0cae7215730b6e296"
    subscription = Payjp::Subscription.create(
      customer: card.customer_id,
      plan: Plan.first.plan_id,
      metadata: {user_id: current_user.id}
    )
    return subscription
  end

  def self.show_card(card)
    Payjp.api_key = "sk_test_d7339cf0cae7215730b6e296"
    customer = Payjp::Customer.retrieve(card.customer_id)
    card_information = customer.cards.retrieve(card.card_id)
    return card_information
  end

  def self.cancel(current_user)
    Payjp.api_key = "sk_test_d7339cf0cae7215730b6e296"
    subscription = Payjp::Subscription.retrieve(current_user.subscription_id)
    customer = Payjp::Customer.retrieve(current_user.card.customer_id)
    subscription.cancel
    customer.delete
  end
end
