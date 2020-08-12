class CategoriesController < ApplicationController
  def index
    @categories = Category.where(ancestry: nil)
  end
  def show
    category_list = []
    get_category = Category.find(params[:id])
    category_list << params[:id].to_i
    if get_category.children
      get_category.children.each do |child|
        category_list << child.id
        if child.children
          child.children.each do |gchild|
            category_list << gchild.id
          end
        end
      end
    end
    @items = Item.where(category_id: category_list)
    @categories = Category.where(ancestry: nil)
    @category = Category.find(params[:id])
  end
  
  def brand
    @categories = Category.where(ancestry: nil)
    @items = Item.where(brand: params[:id])
  end
  
  def brandIndex
    @categories = Category.where(ancestry: nil)
    @items = Item.where(brand: params[:id])
    
  end
end
