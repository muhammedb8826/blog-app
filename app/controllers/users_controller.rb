class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:posts)
    # @users = User.all # assuming you have a User model
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(author_id: @user.id)
  end
end
