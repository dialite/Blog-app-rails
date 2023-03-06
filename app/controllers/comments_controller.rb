class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    respond_to do |format|
      format.html do
        if @comment.save
          redirect_to user_post_path(current_user, @comment.post_id)
          flash[:success] = 'Comment successfully created'
        else
          render :create
          flash.now[:error] = 'Error: Comment failed to save'
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
