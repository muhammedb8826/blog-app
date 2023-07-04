class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:create]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(author_id: current_user.id, post_id: params[:post_id], **comment_params)

    if @comment.save
      flash[:notice] = 'Your comment was added successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:alert] = 'Opps, something went wrong, try again!'
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.comments_counter -= 1
    @comment.post.save
    @comment.destroy
    redirect_to user_posts_path(@comment.user.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
