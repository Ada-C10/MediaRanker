class UsersController < ApplicationController

  def index
    @users = User.all
  end

  # def show
  #   id = params[:id].to_i
  #   @user = User.find_by(id: id)
  #
  #   if @user.nil?
  #     render :notfound, status: :not_found
  #   end
  # end

  def create
    @user = User.new(name: params[:user][:user_name])
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit
      @user = User.find(params[:id].to_i)
  end
end
