class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      head :not_found
    end
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      render :new , status: :bad_request
    end
  end


  def edit
    @user = User.find_by(id: params[:id])
  end


  def update
    @user = User.find_by(id: params[:id])

    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit , status: :bad_request
    end
  end


  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    redirect_to users_path
  end


  def user_params
    return params.require(:user).permit(:username)
  end
  
end
