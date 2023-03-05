class LikesController < ApplicationController
  @like = current_user.likes.build(post_id: params[:post_id])

  if @like.save
    redirect_to user_post_likes_path(current_user, @like.post_id), success: 'Like successfully added'
  else
    flash.now[:error] = 'Error: Like failed to save'
    render :create
  end
end
