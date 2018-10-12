class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    user = User.new(user_params)

    user.save

    redirect_back(fallback_location: new_session_path)

  end

  private

  def user_params
    return params.require(:user).permit(
      :username
    )
  end

end
