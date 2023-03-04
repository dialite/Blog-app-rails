class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user_id = User.find(params[:id])
    @recent_posts = @user_id.recent_posts
  end
end
