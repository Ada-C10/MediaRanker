class UsersController < ApplicationController
  before_action :find_work, only: [:show]
  before_action :find_user_works, only: :show

  def new
    @user = User.new()
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user == nil
      flash.now[:failure]
      render 'layouts/invalid_page', status: :not_found
    end
  end

  def create
    filtered_user_params = user_params()
    @user = User.new(filtered_user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User #{@user.username} has successfully signed up and logged in!"
      redirect_to root_path
    else
      flash.now[:failure] = "Error: user could not be saved."
      render :new, status: 400
    end
  end

  private

  #strong params
  def user_params
    return params.require(:user).permit(
      :username
    )
  end

  def find_user
      @user = User.find_by(id: params[:id])
  end

  def find_user_works
    @user_votes = @votes.find_votes_by_user(params[:id])
  end
end
