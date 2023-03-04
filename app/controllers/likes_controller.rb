class LikesController < ApplicationController
  def create
    @like = current_user.likes.new
    @like.post_id = params[:post_id]

    if @like.save
      redirect_to user_post_likes_path(current_user, @like.post_id)
      flash[:success] = "Like successfully added"
    else
      render :create
      flash.now[:error] = "Error: Comment failed to save"
    end
  end
end
