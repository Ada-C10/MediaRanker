class UsersController < ApplicationController
  def index
    @users = (User.all).sort_by do |user|
      user.id
    end
  end

<<<<<<< HEAD
  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    if @user.nil?
      head :not_found
    end
  end

=======
>>>>>>> controllers
  def new
    @user = User.new
  end

  def create
<<<<<<< HEAD
    @user = User.new(username: params[:user][:username])
    if @user.save
      flash[:notice] = "User created successfully!"
      redirect_to users_path
    else
      render :new, status: :bad_request
=======
    filtered_user = user_params()
    @user = User.new(filtered_user)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
>>>>>>> controllers
    end
  end


  private

<<<<<<< HEAD
=======
  def user_params
    return params.require(:user).permit(:username)
  end
>>>>>>> controllers
end
