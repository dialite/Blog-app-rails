class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    redirect_to new_user_session_path if current_user.nil?
    @users = User.all
  end

  def show
    @user_id = User.find(params[:id])
    @recent_posts = @user_id.recent_posts
  end
end
