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
    user = User.find_by(username: username)

    if user
      flash[:success] = "logged in as #{username}"
      session[:test] = user.id
      redirect_to user_path(user)
    else
      flash.now[:error] = "user doesn't exist"
      render :new
    end

  end

  def logout
    session[:test] = nil
    flash[:success] = "successfully logged out"
    redirect_to root_path
  end

end
