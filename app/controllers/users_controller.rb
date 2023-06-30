class UsersController < ApplicationController
  def index
    @users = User.includes(:posts)
    # @users = User.all # assuming you have a User model
  end

  def show
    @user = User.find(params[:id])
  end
end
