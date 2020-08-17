class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :get_categories

  def index
  end

  def show
  end


  def new
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to user_path
    else
      render :edit
    end  
  end  

  def confirmation
    @item = Item.find(params[:id])
  end

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end
end
