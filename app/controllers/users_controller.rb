class UsersController < ApplicationController
  def index
    @users = User.all.order(:username)
  end

  def show
    id = params[:id].to_i
    @user = User.find(params[:id].to_i)

    if id.nil?
      render :notfound
    end
  end
end
