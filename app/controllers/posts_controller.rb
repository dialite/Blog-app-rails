class PostsController < ApplicationController
  before_action :set_user, only: %i[index show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
    @user_recent_posts = @user.recent_posts
  end
end
