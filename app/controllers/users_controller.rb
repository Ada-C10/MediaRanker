class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id].to_i)
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path
    else
      render :new
    end
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path
    else
      render :new
    end
  end

  private
  def user_params
    return params.require(:user).permit(:username)
  end
end
