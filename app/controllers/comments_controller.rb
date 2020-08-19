class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to item_path(params[:id])
    else
      redirect_to item_path(params[:id]), message: "コメントできませんでした。"
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:comment).merge(item_id: params[:id], user_id: current_user.id)
  end
end
