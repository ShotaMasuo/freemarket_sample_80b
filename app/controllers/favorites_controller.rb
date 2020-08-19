class FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(user_id: current_user.id, item_id: params[:id])
    if !Favorite.where(item_id: params[:id]).where(user_id: current_user.id).exists?
      if favorite.save
        redirect_to item_path(params[:id])
      else
        redirect_to item_path(params[:id]),{message: "失敗"}
      end
    else
      redirect_to item_path(params[:id]),{message: "失敗"}
    end
  end
end
