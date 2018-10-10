class UsersController < ApplicationController
  def index
    @users = (User.all).sort_by do |user|
      user.id
    end
  end

  def new
    @user = User.new
  end

  def create
    filtered_user = user_params()
    @user = User.new(filtered_user)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
