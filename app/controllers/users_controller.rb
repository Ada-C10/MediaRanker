class UsersController < ApplicationController

  def index
    @users = User.all.order(:created_at)
  end

  def show
    @user = User.find_by(id: params[:id])
    @votes = Vote.find(@user.votes.ids) # returns Array of Votes
  end

  private

  # def user_params
  #   return params.require(:user).permit(:name)
  # end

end
