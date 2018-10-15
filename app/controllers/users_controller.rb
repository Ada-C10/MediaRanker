class UsersController < ApplicationController
  def index
    @users = User.order(:username)
  end
  # question: how come we don't need create or new actions? the user controller creates the user, but doesn't not saves them
  # def create
  # end
  #
  # def new
  # end

  def show
    @user = User.find_by(id: params[:id])
  end

  private
  def user_params
    return params.require(:user).permit(:username, :id)
  end
end
