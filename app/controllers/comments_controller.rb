class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params.merge(post_id: @post.id))

    if @comment.save
      redirect_to user_post_comments_path(current_user, @post)
      flash[:success] = 'Comment successfully created'
    else
      flash.now[:error] = 'Error: Comment failed to save'
      render :create
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
