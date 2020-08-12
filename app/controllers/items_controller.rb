class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_categories
  
  def index
  end

  def show
  end
  def confirmation
    @item = Item.find(params[:id])
  end

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end
end
