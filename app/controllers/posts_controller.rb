class PostsController < ApplicationController
  before_action :set_user, only: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end