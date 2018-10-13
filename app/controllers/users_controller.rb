class UsersController < ApplicationController
before_action :find_user, only: [:show]
# Not setting date joined...
after_action :set_date_joined, only: [:create]


  def index
    # Current user will be that model, else it will be nil (not logged in)
    # Use a filter here - Run this method every time
    # Always find the user or always find the top 10
    @users = User.all.order(:name)
  end

  def show
    @user_votes = @user.votes
  end

  def new
    @user = User.new
  end

  # Do I need this?
  # def create
  # end


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

  private
  def set_date_joined
    @user.date_joined = @user.date_created.to_date
  end
end
