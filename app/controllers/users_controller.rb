class UsersController < ApplicationController
  before_action :get_categories

  def index
  end

  def show
    @nickname = current_user.nickname
    @items = current_user.items
  end

  def saleitem
    @items = current_user.items
  end  

  def favorites
    @items = Item.where()
  end
  
  def history
  end
  
  def point
    @points = current_user.point.point
  end
  
  def profile
    @profile = current_user.profile
  end
  
  def logoutbtn
  end  

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end
end

