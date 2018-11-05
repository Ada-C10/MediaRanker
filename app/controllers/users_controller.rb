class UsersController < ApplicationController
before_action :find_user, only: [:show]
# Not setting date joined...
after_action :set_date_joined, only: [:create]


  def index
    @users = User.all.order(:name)
  end

  def show
    @user_votes = @user.votes
  end

  def new
    @user = User.new
  end

  private

  def user_params
    return params.require(:user).permit(:date_joined, :name)
  end

  def find_user
    id = params[:id].to_i
    @user = User.find_by(id: id)
    if @user.nil?
      flash.now[:danger] = "Cannot find the user #{params[:id]}"
      render :notfound
    end
  end

  def set_date_joined
    @user.date_joined = @user.date_created.to_date
  end
end
