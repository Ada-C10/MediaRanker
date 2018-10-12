class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @work = Work.where(user_id: params[:id])

    if @user.nil?
      head :not_found
    end
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
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(user.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @user.destory

    redirect_to users_path
  end

  private

  def user_params
    return params.require(:user).permit(
      :username
    )
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
