class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destory]

  def index
    @users = User.all
  end


  def show
    if @user.nil?
      head :not_found
    end
  end


  def edit
  end


  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit , status: :bad_request
    end
  end


  def destroy
    @user.destroy
    redirect_to users_path
  end


  private

  def user_params
    return params.require(:user).permit(:username)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

end
