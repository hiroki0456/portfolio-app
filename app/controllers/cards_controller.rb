class CardsController < ApplicationController
  before_action :move_to_index, only: [:new]
  def new
    @card = Card.new
  end

  def create
    if current_user.card
      redirect_to root_path
    else
      begin
        Card.transaction do
          customer = Card.card_create(params[:card][:token])
          @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
          if @card.save
            subscription = Card.pay(current_user)
            current_user.update(subscription_id: subscription.id, premium: true)
            flash[:alert] = '定期課金に登録できました'
            redirect_to root_path
          else
            render :new
          end
        end
      rescue => e
        flash[:alert] = '定期課金に失敗しました'
        redirect_to root_path
      end
    end
  end

  def show
    card = Card.find(params[:id])
    @card_information = Card.show_card(card)
  end

  def destroy
    card = Card.find(params[:id])
    Card.cancel(current_user)
    card.destroy
    flash[:alert] = '定期課金を中止しました'
    redirect_to root_path
  end

  private

  def move_to_index
    redirect_to root_path if user_signed_in? && current_user.philosopher
  end
end
