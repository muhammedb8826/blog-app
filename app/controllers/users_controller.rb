class UsersController < ApplicationController
  def index
    @users = User.all # assuming you have a User model
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    # rest of your create method as usual
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    # rest of your update method as usual
  end
  def destroy
    @user = User.find(params[:id])
    # rest of your destroy method as usual
  end
end
