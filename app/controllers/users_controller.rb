class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    filtered_user_params = user_params()
    @user = User.new(filtered_user_params)

    if @user.save
      redirect_to users_path
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update(user_params)
      redirect_to user_path(user.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destory

    redirect_to users_path
  end

  private

  def user_params
    return params.require(:work).permit(
      :username
    )
  end
end
