class Api::V1::CommentsController < ApplicationController
  before_action :authorize_request, only: [:create]

  # fetch user including their posts and comment and render
  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @post = @user.posts.find_by(id: params[:post_id])
    render json: @post ? @post.comments : "No comment for post: #{params[:post_id]}"
  end

  # create a new comment associated with the post and render
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.post_id = @post.id
    render json: @comment if @comment.save
  end

  def comment_params
    params.require(:comment).permit(:text, :post_id, :author_id) # allow only certain parameters
  end
end