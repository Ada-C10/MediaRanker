class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
    end
  end


  def new
  end

  def create
    username = params[:username]
    @user = User.new(params[:user][:username])


    if @user.save
      flash[:success] = "New user successfully added"
    else
      flash[:error] = "user could not be added"
    end
  end


  def login
    username = params[:username]
    user = User.find_by(username: username)

    if user
      flash[:success] = "logged in as #{username}"
      session[:test] = user.id
      redirect_to user_path(user)
    else
      # render :create
      flash[:error] = "user doesn't exist"
      render :create
    end

  end


  def logout
    session[:test] = nil
    flash[:success] = "successfully logged out"
    redirect_to root_path
  end


  private
  def user_params
    return params.require(:user).permit(:username)
  end

end
