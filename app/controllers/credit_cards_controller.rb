class CreditCardsController < ApplicationController
  require "payjp"
  
  def new
    @categories = Category.where(ancestry: nil)
    current_card = CreditCard.where(user_id: current_user.id).first
    redirect_to credit_card_path(current_card.id) if current_card
  end
  
  def show
    @categories = Category.where(ancestry: nil)
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new" 
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
  
  def create
    # 前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    # 後ほどトークン作成処理を行いますが、そちらの完了の有無でフラッシュメッセージを表示させます。
    if params["payjp_token"].blank?
      redirect_to action: "new"
    else
      # 無事トークン作成された場合のアクション(こっちが本命のアクション)
      # まずは生成したトークンから、顧客情報と紐付け、PAY.JP管理サイトに登録
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp_token"],
        metadata: {user_id: current_user.id} #最悪なくてもOK！
        )
        # 今度はトークン化した情報を自アプリのCredit_cardsテーブルに登録！
        @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        # 無事、トークン作成とともにcredit_cardsテーブルに登録された場合、createビューが表示されるように条件分岐
        if @card.save
          redirect_to user_path(current_user.id)
        else
          redirect_to new_credit_card_path
        end
      end
    end
    
    def destroy
      @card = CreditCard.find_by(user_id: current_user.id)
      if @card.blank?
        redirect_to action: "new"
      else
        # credentials.yml.encに記載したAPI秘密鍵を呼び出します。
        Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
        # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
        customer = Payjp::Customer.retrieve(@card.customer_id)
        customer.delete
        @card.delete
        if @card.destroy
          redirect_to user_path(current_user.id)
        else
          current_card = CreditCard.where(user_id: current_user.id)
          redirect_to credit_card_path(current_card.id)
        end
      end
    end
    
  end
  