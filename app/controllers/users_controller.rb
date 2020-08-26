class UsersController < ApplicationController
  before_action :get_categories

  def index
  end

  def show
    @nickname = current_user.nickname
    @items = current_user.items
  end

  def saleitem
    @items = Item.where(user_id: current_user.id).where(stage: "0")
  end  

  def tradeitem
    @items = Item.where(user_id: current_user.id).where(stage: "1").or(Item.where(user_id: current_user.id).where(stage: "2"))
  end

  def solditem
    @items = Item.where(user_id: current_user.id).where(stage: "3")
  end

  def favorites
    @favorites = Favorite.where(user_id: current_user.id)
  end
  
  def history
    @purchases = Purchase.where(user_id: current_user.id)
  end
  
  def point
    @points = Point.where(user_id: current_user.id)
  end
  
  def profile
    @address = current_user.address
  end
  
  def logoutbtn
  end  

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end
end

