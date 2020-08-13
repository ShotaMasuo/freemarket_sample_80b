class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :get_categories

  def index
  end

  def show
  end


  def new
  end

  def confirmation
    @item = Item.find(params[:id])
    @user = User.find(current_user.id)
  end
  require "payjp"
  def pay
    @item = Item.find(params[:id])
    if @item.stage != "selling"
      redirect_to item_path(params[:id])
    else
      @item.with_lock do
        if current_user.credit_card.present?
          @card = CreditCard.find_by(user_id: current_user.id)
          Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
          charge = Payjp::Charge.create(
            amount: @item.price,
            customer: Payjp::Customer.retrieve(@card.customer_id),
            currency: 'jpy'
            )
        else
          Payjp::Charge.create(
            amount: @item.price,
            # フォームを送信すると作成・送信されてくるトークン
            card: params['payjp-token'],
            currency: 'jpy'
            )
        end
        @purchase = Purchase.create(user_id: current_user.id, item_id: params[:id])
        item = Item.find(params[:id])
        item.update(stage: 1)
        redirect_to root_path
      end
    end
  end

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end
end
