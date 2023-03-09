class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(author_id: current_user.id))

    if @comment.save
      flash[:success] = 'Comment successfully created'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:error] = 'Error: Comment failed to save'
      render :new
    end
  end

  private

  def comment_params
    if params.key?(:comment)
      params.require(:comment).permit(:text)
    else
      {}
    end
  end
end
