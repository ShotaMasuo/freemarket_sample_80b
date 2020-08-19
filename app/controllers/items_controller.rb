class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  before_action :get_categories
  
  before_action :get_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:images).order('created_at DESC').limit(5)
    @favorites = Favorite.includes(:item).group(:item_id).count
  end
  
  def show
    @prefecture = Prefecture.find(@item.prefecture).name
    @favorites = Favorite.where(item_id: params[:id]).count
  end


  def new
    @category_array = []
    @categories.each do |category|
      category.children.each do |child|
        child.children.each do |gchild|
          @category_array << [category.name, category.id]
          @category_array << [child.name, child.id]
          @category_array << [gchild.name, gchild.id]
        end
      end
    end
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

  def confirmation
    @user = User.find(current_user.id)
  end
  require "payjp"
  def pay
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

  def item_params
    params.require(:item).permit(:name, :price, :size, :condition, :brand, :stage, :detail, :category_id, :prefecture, :fee, :delivery_date, images_attributes: [:image, :destroy, :id]).merge(user_id: current_user.id)
  end

  def get_item
    @item = Item.find(params[:id])
  end
end
