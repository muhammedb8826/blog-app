class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    respond_to do |format|
      format.html do
        @pagination = @posts.size > 2
        return unless @pagination

        @page = params[:page].to_i || 1
        @totla_pages = (@posts.size + 1) / 2
        @posts = @posts.limit(2).offset((@page - 1) * 2)
      end
      format.json { render json: @posts }
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.destroy
    @user.posts_counter -= 1
    @user.save
    redirect_to user_posts_path(@user)
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
