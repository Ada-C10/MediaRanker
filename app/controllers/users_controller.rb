class UsersController < ApplicationController
  def index
    @users = User.order(:name)

    @current_user = User.find_by(id: session[:user_id])
    
  end

  def show
    @user = User.find_by(id: params[:id].to_i)

    if @user.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path(@user_id)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id].to_i)
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    return params.require(:user).permit(:name) #this data is coming from the form
  end


end
