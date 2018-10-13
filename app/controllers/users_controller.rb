class UsersController < ApplicationController
  def new
    @user = User.new
  end


  def show
     @user = User.find_by(id: params[:id])
     if @user.nil?
       head :not_found
     end

  end


  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end



  private

  def user_params
    return params.require(:username).permit(:username)
  end


end
