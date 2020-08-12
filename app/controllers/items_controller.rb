class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_categorys
  
  def index
  end

  def show
  end

  def new
  end
end
  def confirmation

  end

  private
  def get_categorys
    @categories = Category.where(ancestry: nil)
  end
end
