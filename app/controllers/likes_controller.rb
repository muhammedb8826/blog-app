class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @like = Like.new
  end

  def create
    @like = Like.new(author_id: current_user.id, post_id: params[:post_id])

    if @like.save
      flash[:notice] = 'Your like was saved successfully'
    else
      flash[:alert] = 'Something went wrong, please try again.'
    end
    redirect_to user_posts_path(params[:user_id])
  end
end
