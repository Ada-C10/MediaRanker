class UsersController < ApplicationController
  before_action :find_user

  def index
    @users = (User.all).sort_by do |user|
      user.id
    end
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(username: params[:user][:username])
    if @user.save
      flash[:notice] = "User created successfully!"
      redirect_to users_path
    else
      render :new, status: :bad_request
    end
  end

  private
  def find_user
    @user = User.find_by(id: params[:user_id] )
  end

  def user_params
    return params.require(:user).permit(:username)
  end

end
