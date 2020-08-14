class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :get_categories
  
  before_action :set_item, except: [:index, :new, :create]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def show
  end


  def new
    @category_array = []
    @categories.each do |category|
      category.children.each do |child|
        child.children.each do |gchild|
          @category_array << [category.name, category.id]
          @category_array << [child.name, child.id]
          @category_array << [gchild.name, gchild.id]
        end
      end
    end
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def confirmation
    @item = Item.find(params[:id])
  end

  private
  def get_categories
    @categories = Category.where(ancestry: nil)
  end

  def item_params
    params.require(:item).permit(:name, :price, :size, :condition, :brand, :stage, :detail, :category_id, :prefecture, :fee, :delivery_date, images_attributes: [:image, :destroy, :id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
