class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]


  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:author).order(created_at: :desc)
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(author_id: currrent_user.id, post_id: params[:post_id], **comment_params)

    if @comment.save
      flash[:notice] = 'Your comment was added successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:alert] = 'Opps, something went wrong, try again!'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
