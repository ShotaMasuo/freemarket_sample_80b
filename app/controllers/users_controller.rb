class UsersController < ApplicationController
  before_action :get_categorys

  def index
  end

  def show
  end

  private
  def get_categorys
    @categories = Category.where(ancestry: nil)
  end

end

