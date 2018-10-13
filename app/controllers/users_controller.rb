class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to root_path
  end

  def show
    @user = User.find_by(id: params[:id])
    user_id = params[:id]
  end

  def update
    @user = User.find(params[:id])
    @user.update(work_params)
    redirect_to works_path
  end

  private

  def user_params
    return params.require(:user).permit(
      :username)
    end
  end
