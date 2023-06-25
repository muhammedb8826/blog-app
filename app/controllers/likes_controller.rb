class LikesController < ApplicationController
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