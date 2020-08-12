class UsersController < ApplicationController
  before_action :get_categories

  def index
  end

  def show
  end

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end
end

