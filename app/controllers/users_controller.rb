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
    @user = User.new
  end


  def login
    username = params[:username]
    user = User.find_by(username: params[:username])

    if user
      flash[:success] = "logged in as #{username}"
      session[:user_id] = user.id
      redirect_to user_path(user) and return
    else

      @user = User.new(username: username)

      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "New user successfully added"
        redirect_to user_path(@user.id) and return
      else
        render :new
      end
    end
  end


  def logout
    session[:user_id] = nil
    flash[:success] = "successfully logged out"
    redirect_to root_path
  end


  private
  def user_params
    return params.require(:user).permit(:username)
  end

end
