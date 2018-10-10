class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(:id)
  end

  def show; end
  #uses the filter to find user
  #   id = params[:id]
  #   @user = User.find_by(id: id)
  #
  #   if id == nil
  #     render :not_found, status: :not_found
  #   end
  #
  # end

  def edit; end
  #uses the filter to find user
  #   id = params[:id]
  #   @user = User.find_by(id: id)
  # end

  def new
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      user = User.create(username: params[:user][:username])
      if user.valid? == false
        flash[:danger] = "Login Unsuccessful"
      end
    end

    session[:user_id] = user.id

    if user.valid?
      flash[:success] = "#{user.username} is successfully logged in"
    end
    redirect_to root_path
  end

  # def update
  #   if @user && @user.update(user_params)
  #   # id = params[:id]
  #   # @user = User.find_by(id: id)
  #   # @user.update(user_params)
  #   # if @user.save
  #   #   redirect_to users_path # go to the index so we can see the book in the list
  #   # else
  #     render :new
  #   end
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to root_path
  #     render :new
  #   end
  # end

  def destroy
    # id = params[:id]
    # @user = User.find_by(id: id)
    # if @user.destroy
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
      redirect_back fallback_location: root_path
    end



end

private

  def find_user
    id = params[:id]
    @user = User.find_by(id: id)

    if @user.nil?
      flash.now[:warning] = "Cant find the user"
      render :notfound
    end
  end

  def user_params
    return params.require(:user).permit(:username)
  end
