class PostsController < ApplicationController
  before_action :set_user, only: %i[index show]

  def index
    @posts = Post.all
  end

  def show
    @current_user = current_user
    @post = Post.find(params[:id])
    @comment = Comment.new
    @like = Like.new
    @user = User.find_by(id: params[:user_id])
  end

  def set_user
    @user = User.find(params[:user_id])
    @user_recent_posts = @user.recent_posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post successfully created'
          redirect_to "/users/#{current_user.id}/posts/#{@post.id}"
        else
          flash.now[:error] = 'Error: Post failed to save'
          render :new
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    current_user.posts_counter -= 1
    current_user.save
    redirect_to user_path(current_user.id)
    puts 'You are deleting this post'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end
end
