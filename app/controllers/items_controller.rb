class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @categories = Category.where(ancestry: nil)
  end

  def show
  end
  def confirmation

  end
end
