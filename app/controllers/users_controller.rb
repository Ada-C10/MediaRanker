class UsersController < ApplicationController
  def index
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @users = User.all
  end

  def show
    @current_user = User.find_by(id: session[:user_id])
    # user id will be nil if not logged in or whole author model if they are logged in

    @user = User.find_by(id: params[:id].to_i)

    if @user.nil?
      render :notfound, status: :not_found
    end
  end
end
