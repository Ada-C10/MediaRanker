class UsersController < ApplicationController
  def index
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @users = User.all
  end

  def show
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @users = User.find_by(id: params[:id].to_i)

    if @user.nil?
      render :notfound, status: :not_found
    end
  end

  # TODO: delete this method and associations
  def new
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.joined = Date.today

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
