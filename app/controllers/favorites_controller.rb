class FavoritesController < ApplicationController
  def create
    @flug = 0
    if !Favorite.where(item_id: params[:id]).where(user_id: current_user.id).exists?
      favorite = Favorite.new(user_id: current_user.id, item_id: params[:id])
      favorite.save
      @flug = 1
    else
      favorite = Favorite.where(user_id: current_user.id).where(item_id: params[:id])
      favorite[0].destroy
    end
    @favorites = Favorite.where(item_id: params[:id]).count
    respond_to do |format|
      format.json
    end
  end
end
