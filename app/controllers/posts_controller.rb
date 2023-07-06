class PostsController < ApplicationController

  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(author_id: current_user.id, **post_params)

    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:alert] = 'Something went wrong. Please try again!'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
