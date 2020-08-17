class UsersController < ApplicationController
  before_action :get_categories

  def index
  end

  def show
    @user = User.find(current_user.id)
    @items = Item.where(user_id: current_user.id)
  end

  def saleitem
    @user = User.find(current_user.id)
    @items = Item.where(user_id: current_user.id)
  end  

  def favorites
    @items = Item.where()
  end
  
  def history
  end
  
  def point
    @points = Point.find_by(user_id: current_user.id)
  end
  
  def profile
    @profile = Profile.find_by(user_id: current_user.id)
  end
  
  def logoutbtn
  end  

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end
end

