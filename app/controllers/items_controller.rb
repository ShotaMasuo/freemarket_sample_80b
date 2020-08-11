class ItemsController < ApplicationController
  def index
    @categories = Category.where(ancestry: nil)
  end

  def show
  end
end
