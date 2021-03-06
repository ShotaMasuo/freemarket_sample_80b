class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :get_categories

  before_action :get_item, except: [:index, :new, :create, :image_destroy, :get_category_children, :get_category_grandchildren]
  require "payjp"
  def index
    @items = Item.where(stage: 0).includes(:images).order('created_at DESC').limit(5)
    @favorites = Favorite.includes(:item).group(:item_id).count
  end

  def show
    @prefecture = Prefecture.find(@item.prefecture).name
    @favorites = Favorite.includes(:item).group(:item_id).count
    if user_signed_in?
      @flug = Favorite.where(item_id: params[:id]).where(user_id: current_user.id)
    end
    @comment = Comment.new
    @comments = Comment.where(item_id: params[:id])
    @otherItems = Item.where(user_id: @item.user_id).where.not(id: params[:id])
  end

  def new
    @category_array = Category.where(ancestry:nil)
    @item = Item.new
    @item.images.new
  end

  def get_category_children
    @category_children = Category.find(params[:category_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
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
    @grandchild = Category.find(@item.category_id)
    @child = @grandchild.parent
    @parent = @child.parent
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if !@item.destroy
      render :edit
    end
  end

  def image_destroy
    Image.destroy(params[:id])
  end

  def point
    @point = Point.where(user_id: current_user.id)[0]
    @item = Item.find(params[:id])
    if @point == nil
      Point.create(point: 0, user_id: current_user.id)
      @point = Point.where(user_id: current_user.id)[0]
    end
  end

  def confirmation
    @use_point = params[:use_point]
    @final_price = @item.price - params[:use_point].to_i
    @user = User.find(current_user.id)
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to new_credit_card_path
    else
      # 前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # カスタマー情報からカードの情報を引き出す
      @customer_card = customer.cards.retrieve(@card.card_id)

      #  viewの記述を簡略化
      @card_no = "**** **** ****" + @customer_card.last4
      ## 有効期限'月'を定義
      @exp_month = @customer_card.exp_month.to_s
      ## 有効期限'年'を定義
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  require "payjp"
  def pay
    final_price = params[:final_price].to_i
    use_point = params[:use_point].to_i
    if @item.stage != "selling"
      redirect_to item_path(params[:id])
    else
      @item.with_lock do
        if current_user.credit_card.present?
          @card = CreditCard.find_by(user_id: current_user.id)
          Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
          charge = Payjp::Charge.create(
            amount: final_price,
            customer: Payjp::Customer.retrieve(@card.customer_id),
            currency: 'jpy'
            )
        else
          Payjp::Charge.create(
            amount: final_price,
            # フォームを送信すると作成・送信されてくるトークン
            card: params['payjp-token'],
            currency: 'jpy'
            )
        end
        @purchase = Purchase.create(user_id: current_user.id, item_id: params[:id])
        item = Item.find(params[:id])
        item.update(stage: 1)
        current_user.point.update(point: current_user.point.point + final_price/10 - use_point)

        redirect_to root_path
      end
    end
  end

  def get_category_children
    @category_children = Category.find(params[:category_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end

  def item_params
    params.require(:item).permit(:name, :price, :size, :condition, :brand, :detail, :category_id, :prefecture, :fee, :delivery_date, images_attributes: [:image, :destroy, :id]).merge(user_id: current_user.id)
  end

  def get_item
    @item = Item.find(params[:id])
  end
end
