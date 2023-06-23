class UsersController < ApplicationController
  def index
    @users = User.all # assuming you have a User model
  end

  def show
    @user = User.find_by_id(params[:id])
  end
end
