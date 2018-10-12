class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      head :not_found
    end

    @votes = Vote.where(user: @user)


  end

  def new
    @user = User.new
  end

end
