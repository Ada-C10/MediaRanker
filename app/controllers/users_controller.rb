class UsersController < ApplicationController
  def index
    @users = User.all.order(:title)
  end

  def show
    id = params[:id]
    @user = User.find_by(id: id)

    if @user.nil?
      render :notfound, status: :not_found
    end
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end


  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    redirect_to users_path
  end

  private

  def user_params
    return params.require(:user).permit(:title)
  end
end
