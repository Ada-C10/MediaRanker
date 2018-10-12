class UsersController < ApplicationController
  def index
    @users = User.order(:name)

    @current_user = User.find_by(id: session[:user_id])
    #this finds the current user in the session so i can display it where i need

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
  end

  def edit
    @user = User.find_by(id: params[:id].to_i)
  end

  def update
  end

  def destroy
  end


end
